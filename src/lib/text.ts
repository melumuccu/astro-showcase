export const kebabToPascal = (str: string) => {
  return str
    .split('-')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join('')
}

export const pascalToKebab = (str: string) => {
  return str.replace(/(?<!^)([A-Z])/g, '-$1').toLowerCase()
}
