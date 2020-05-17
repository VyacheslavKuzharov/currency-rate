class Flash {

    constructor() {
        this.speed = 2000;
    }

    removeFadeOut(el) {
        if(el) {
            setTimeout( () => {
                let seconds = this.speed/1000;
                el.style.transition = "opacity "+seconds+"s ease";
                el.style.opacity = 0;

                this._removeEl(el)
            }, this.speed);
        }
    }

    _removeEl(el) {
        setTimeout( () =>  {
            el.parentNode.removeChild(el);
        }, this.speed);
    }
}

export let flash = new Flash();