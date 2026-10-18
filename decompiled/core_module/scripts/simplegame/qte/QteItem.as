package simplegame.qte
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class QteItem extends Sprite implements Disposeable
   {
      
      private var _isRight:Boolean;
      
      private var _data:String;
      
      private var _mc:MovieClip;
      
      private var _containerMc:MovieClip;
      
      private var _okEffect:MovieClip;
      
      public function QteItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         mouseChildren = mouseEnabled = false;
         _mc = ComponentFactory.Instance.creatCustomObject("asset.qte.QTEItem");
         _containerMc = ComponentFactory.Instance.creatCustomObject("asset.qte.QTEItemShowEf");
         _okEffect = ComponentFactory.Instance.creatCustomObject("asset.qte.QTEItemOkEffect");
         _mc.gotoAndStop(1);
         _mc.bg.gotoAndStop(1);
         _mc.arrow.gotoAndStop(1);
         _okEffect.gotoAndStop(1);
         addChild(_containerMc);
         addChild(_okEffect);
         _containerMc.qteIcon.addChild(_mc);
         _containerMc.gotoAndStop(1);
      }
      
      public function get data() : String
      {
         return _data;
      }
      
      public function set data(param1:String) : void
      {
         _data = param1;
         _mc.arrow.rotation = getIndexByKey(_data);
         _okEffect.rotation = getIndexByKey(_data);
         _mc.key.gotoAndStop(_data);
         _containerMc.gotoAndPlay(1);
      }
      
      private function getIndexByKey(param1:String) : int
      {
         switch(param1)
         {
            case "W":
               return 0;
            case "D":
               return 90;
            case "S":
               return 180;
            case "A":
               return -90;
            default:
               return 0;
         }
      }
      
      public function get isRight() : Boolean
      {
         return _isRight;
      }
      
      public function set isRight(param1:Boolean) : void
      {
         _isRight = param1;
         if(_isRight)
         {
            _mc.arrow.gotoAndStop(2);
            _mc.bg.gotoAndStop(2);
            _okEffect.gotoAndPlay(1);
         }
         else
         {
            _mc.arrow.gotoAndStop(1);
            _mc.bg.gotoAndStop(1);
         }
      }
      
      public function tweenEffect(param1:Boolean) : void
      {
         _containerMc.gotoAndPlay("quit");
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("addedToStage",__added);
      }
      
      private function __added(param1:Event) : void
      {
         removeEventListener("addedToStage",__added);
      }
      
      public function dispose() : void
      {
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

