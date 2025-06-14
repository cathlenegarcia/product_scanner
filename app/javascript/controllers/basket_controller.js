import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["addButton", "removeButton"]

  async handleAdd(event) {
    const button = event.currentTarget
    const productId = button.dataset.productId
    const url = button.dataset.url

    try {
      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ product_id: productId })
      })

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }

      const data = await response.json()
      
      if (data.success) {
        this.updateBasketPreview(data)
        if (button.closest(".quantity")) {
          button.previousElementSibling.textContent = parseInt(button.previousElementSibling.textContent) + 1
        }
        window.location.reload()
      } else {
        console.error("Failed to add item:", data.errors)
      }
    } catch (error) {
      console.error("Error adding item to basket:", error)
    }
  }

  async handleRemove(event) {
    const button = event.currentTarget
    const productId = button.dataset.productId
    const url = button.dataset.url

    try {
      const response = await fetch(url, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ product_id: productId })
      })

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }

      const data = await response.json()
      
      if (data.success) {
        this.updateBasketPreview(data)
        if (button.closest(".quantity")) {
          const quantityElement = button.nextElementSibling
          const newQuantity = parseInt(quantityElement.textContent) - 1
          if (newQuantity <= 0) {
            button.closest(".border-b").remove()
          } else {
            quantityElement.textContent = newQuantity
          }
        }
        window.location.reload()
      } else {
        console.error("Failed to remove item:", data.errors)
      }
    } catch (error) {
      console.error("Error removing item from basket:", error)
    }
  }

  updateBasketPreview(data) {
    const itemCount = document.getElementById("basket-item-count")
    const basketTotal = document.getElementById("basket-total")
    
    if (itemCount) itemCount.textContent = data.item_count
    if (basketTotal) basketTotal.textContent = data.basket_total
  }
}
