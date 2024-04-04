/**
 * 渡されたElementの最初の要素にフォーカスを当てる
 */
export const focusFirstEl = (el: HTMLElement) => {
  const focusableElements: NodeListOf<HTMLElement> = el.querySelectorAll(
    'a[href], button, input, textarea, select, [tabindex]:not([tabindex="-1"])'
  )

  if (focusableElements.length > 0) {
    focusableElements[0].focus()
  }
}
