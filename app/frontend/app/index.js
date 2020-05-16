// Import App Base styles
import './app.scss'

// Import App Pages styles
const styles = require.context('.', true, /^(?!.*\.app\.scss$).*\.scss$/ );
styles.keys().forEach(styles);