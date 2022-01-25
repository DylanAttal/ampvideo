<template>
  <div id="app">
    <h1><span class="amp">Amp</span><span class="video">Video</span></h1>
    <input class="searchbar" placeholder="Search..." />
  </div>
</template>

<style lang="scss">
body {
  margin: 0;
}

#app {
  font-family: Helvetica, sans-serif;
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100vh;
  width: 100vw;
}

h1 {
  font-weight: 100;
  font-size: 3rem;
}

.amp {
  color: #cc3333;
}

.video {
  color: #333;
}

.searchbar {
  width: 50%;
  font-size: 1rem;
  padding: 0.5rem;
}
</style>
