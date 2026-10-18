package asset.core
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol475")]
   public dynamic class powerMc extends MovieClip
   {
      
      public var old_power:MovieClip;
      
      public var shine1:MovieClip;
      
      public var shine2:MovieClip;
      
      public var new_power:MovieClip;
      
      public function powerMc()
      {
         super();
         addFrameScript(0,this.frame1,19,this.frame20,23,this.frame24);
      }
      
      internal function frame1() : *
      {
         if(this["shine1"])
         {
            this["shine1"].visible = false;
            this["shine1"].gotoAndStop(1);
         }
         if(this["shine2"])
         {
            this["shine2"].visible = false;
            this["shine2"].gotoAndStop(1);
         }
      }
      
      internal function frame20() : *
      {
         if(this["shine1"])
         {
            this["shine1"].visible = true;
            this["shine1"].gotoAndPlay(1);
         }
         if(this["shine2"])
         {
            this["shine2"].visible = true;
            this["shine2"].gotoAndPlay(1);
         }
      }
      
      internal function frame24() : *
      {
         stop();
      }
   }
}

