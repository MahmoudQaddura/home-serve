import { useRef, useEffect } from "react";

// eslint-disable-next-line react/prop-types
const VideoPlayer = ({ videoId }) => {
  const videoRef = useRef(null);
  const backIP = import.meta.env.VITE_BACK_IP;
  console.log(backIP);
  useEffect(() => {
    if (videoRef.current) {
      videoRef.current.pause();
      videoRef.current.removeAttribute("src");
      videoRef.current.load();
    }
  });
  return (
    <video ref={videoRef} width="320" height="240" controls autoPlay>
      <source
        src={`http://${backIP}:3000/videos/${videoId}`}
        type="video/mp4"
      ></source>
      Your browser does not support the video tag.
    </video>
  );
};

export default VideoPlayer;
