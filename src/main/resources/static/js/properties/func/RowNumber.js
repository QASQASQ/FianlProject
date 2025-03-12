/**
 * 
 */

class RowNumberRenderer {
    constructor(props) {
      const el = document.createElement('span');
      el.innerHTML = `No.${props.formattedValue}`;
      this.el = el;
    }

    getElement() {
      return this.el;
    }

    render(props) {
      this.el.innerHTML = `No.${props.formattedValue}`;
    }
}