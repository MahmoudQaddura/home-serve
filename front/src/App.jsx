import { useState } from "react";
import VideoPlayer from "./components/VideoPlayer";

function App() {
  const [videoId, setVideoId] = useState(null);

  function playVideo(e, videoId) {
    e.preventDefault();
    setVideoId(videoId);
  }

  return (
    <div className="App">
      {videoId && <VideoPlayer videoId={videoId}></VideoPlayer>} <br />
      <button
        onClick={(e) => {
          playVideo(e, "one");
        }}
      >
        Play Video 1
      </button>
      <button
        onClick={(e) => {
          playVideo(e, "two");
        }}
      >
        Play Video 2
      </button>
    </div>
  );
}

export default App;
