package map.campaign.view.ui.pvpmap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import map.campaign.view.ui.DownTimeView;
   
   public class PvpPlayerRiverView extends Sprite implements Disposeable
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _txt:FilterFrameText;
      
      private var _downTime:DownTimeView;
      
      public function PvpPlayerRiverView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("campaign.pvpmap.RiverViewBg");
         addChild(_bg);
         _txt = ComponentFactory.Instance.creatComponentByStylename("worldboss.river.riverTxt");
         addChild(_txt);
         _txt.text = LanguageMgr.GetTranslation("map.PvpPlayerRiverView.text");
         _downTime = new DownTimeView();
         _downTime.x = 45;
         _downTime.y = 7;
         addChild(_downTime);
         _downTime.addEventListener("complete",__timeCompleteHandler);
      }
      
      public function set riverTime(param1:int) : void
      {
         if(_downTime)
         {
            _downTime.count = param1;
         }
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         dispose();
      }
      
      public function dispose() : void
      {
         if(_downTime)
         {
            _downTime.removeEventListener("complete",__timeCompleteHandler);
            _downTime.dispose();
         }
         _downTime = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_txt)
         {
            _txt.dispose();
         }
         _txt = null;
         if(_downTime)
         {
            _downTime.dispose();
         }
         _downTime = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

