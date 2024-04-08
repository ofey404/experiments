import i18n from "i18next";
import { initReactI18next } from "react-i18next";

// the translations
// (tip move them in a JSON file and import them,
// or even better, manage them separated from your code: https://react.i18next.com/guides/multiple-translation-files)
const resources = {
  en: {
    translation: {
      "Welcome to React": "Welcome to React and react-i18next",
      "Key Value Example": "Key Value Example, {{value1}}, {{value2}}",
      "Invalid request": "Invalid request from user {{user}}, ID {{id}}"
    }
  },
  zh: {
    translation: {
      "Welcome to React": "欢迎来到 React 和 react-i18next",
      "Key Value Example": "键值示例, {{value1}}, {{value2}}",
      "Invalid request": "不合法请求，来自用户 {{user}}，ID {{id}}"
    }
  }
};

i18n
  .use(initReactI18next) // passes i18n down to react-i18next
  .init({
    resources,
    lng: "en", // language to use, more information here: https://www.i18next.com/overview/configuration-options#languages-namespaces-resources
    // you can use the i18n.changeLanguage function to change the language manually: https://www.i18next.com/overview/api#changelanguage
    // if you're using a language detector, do not define the lng option

    interpolation: {
      escapeValue: false // react already safes from xss
    }
  });

  export default i18n;