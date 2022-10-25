import pytesseract
import re


def error_check(formatted_code):
    # De acordo com o padrão BIC de containers
    # # https://en.wikipedia.org/wiki/ISO_6346

    fixed_code = list(formatted_code)
    n = len(fixed_code)

    if n >= 11:
        # Os primeiros 4 characteres são sempre letras
        for i in range(4):
            if fixed_code[i] == '1':
                fixed_code[i] = 'I'
            if fixed_code[i] == '4':
                fixed_code[i] = 'A'
            if fixed_code[i] == '6':
                fixed_code[i] = 'G'
            if fixed_code[i] == '8':
                fixed_code[i] = 'B'

        # Os próximos 7 characteres são sempre dígitos
        for i in range(4, 11):
            if fixed_code[i] == 'I':
                fixed_code[i] = '1'
            if fixed_code[i] == 'A':
                fixed_code[i] = '4'
            if fixed_code[i] == 'G':
                fixed_code[i] = '6'
            if fixed_code[i] == 'B':
                fixed_code[i] = '8'
            if fixed_code[i] == 'U':
                fixed_code[i] = '0'
            if fixed_code[i] == 'S':
                fixed_code[i] = '5'
            if fixed_code[i] == 'O':
                fixed_code[i] = '0'
    fixed_code = "".join(fixed_code)
    # if n > 11:
    #     # Remove o último caractere se > 11
    #     fixed_code = fixed_code[:-1]

    return fixed_code


def reformat_code(original_code):
    formatted_code = None
    n = len(original_code)
    if n <= 20:
        formatted_code = original_code[:n - 1]
        # Remove espaços
        formatted_code = formatted_code.replace(" ", "")
        # Remove espaços
        formatted_code = formatted_code.replace("\n", "")

    return formatted_code


def build_tesseract_options():
    # Tesseract fazer OCR apenas em caracteres alphanumericos
    alphanumeric = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    options = "--psm 6" + " --oem 3"
    options += f" -c tessedit_char_whitelist={alphanumeric}"
    options += " load_freq_dawg=false load_system_dawg=false"

    return options


def find_code_in_image(img):
    options = build_tesseract_options()
    result = pytesseract.image_to_string(img, config=options)
    result = reformat_code(result)
    result = error_check(result)
    if len(result) == 11:
        # Coloca um espaço após 4 caracteres
        result = insert_space(result, 4)
        # Coloca um espaço antes do digito verificador
        result = insert_space(result, 11)
    if len(result) == 12:
        result = insert_space(result, 4)
        result = insert_space(result, 6)
        result = insert_space(result, 13)

    return result


def insert_space(string, integer):
    return f'{string[:integer]} {string[integer:]}'


def main():
    ...


if __name__ == '__main__':
    main()
