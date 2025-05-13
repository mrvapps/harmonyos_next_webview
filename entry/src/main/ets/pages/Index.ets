import webview from '@ohos.web.webview';
import window from '@ohos.window';
import common from '@ohos.app.ability.common';

interface GeneratedObjectLiteralInterface_1 {
  statusBarColor: string;
  navigationBarColor: string;
  statusBarContentColor: string;
  navigationBarContentColor: string;
}

@Entry
@Component
struct Index {
  private webController: webview.WebviewController = new webview.WebviewController();
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  aboutToAppear() {
    this.enableScreenRotation();
    this.enableFullScreen(); // Ativar o modo tela cheia
  }

  // Adicione este método para controlar o botão voltar
  onBackPress() {
    if (this.webController.accessBackward()) {
      this.webController.backward(); // Volta para a página anterior no WebView
      return true; // Indica que o evento foi tratado
    }
    return false; // Permite o comportamento padrão (sair do app)
  }

  // Ativar rotação de tela
  private async enableScreenRotation() {
    try {
      const win = await window.getLastWindow(this.context);
      win.setPreferredOrientation(window.Orientation.AUTO_ROTATION);
    } catch (err) {}
  }

  // Modo tela cheia para ocupar a barra superior
  private async enableFullScreen() {
    try {
      const win = await window.getLastWindow(this.context);
      // 1. Definir layout de tela cheia
      win.setWindowLayoutFullScreen(true);

      // 2. Configurar barras do sistema para transparente
      const systemBarProps: GeneratedObjectLiteralInterface_1 = {
        statusBarColor: '#00000000', // Cor transparente
        navigationBarColor: '#00000000', // Cor transparente
        statusBarContentColor: '#FF000000', // Cor do conteúdo escuro
        navigationBarContentColor: '#FF000000'
      };
      win.setWindowSystemBarProperties(systemBarProps);
    } catch (err) {}
  }

  build() {
    Column() {
      Web({
        src: "https://www.qwant.com/",
        controller: this.webController
      })
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
    }
}