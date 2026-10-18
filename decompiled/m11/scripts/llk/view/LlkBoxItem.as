package llk.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.LlkManager;
   import mvc.module.llk.LlkBoxData;
   import mvc.module.llk.LlkModel;
   import yishi.filter.UIFilter;
   import yishi.utils.NumberViewUtils;
   
   public class LlkBoxItem extends Component
   {
      
      private var _icon:ScaleFrameImage;
      
      private var _scoreSp:Sprite;
      
      private var _scoreRes:BitmapData;
      
      private var _level:int;
      
      private var _mc:MovieClip;
      
      private var _data:LlkBoxData;
      
      private var _flag:Boolean;
      
      private var _state:int;
      
      private var _filter:UIFilter;
      
      public function LlkBoxItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("LlkBoxItem.icon");
         _scoreRes = ComponentFactory.Instance.creatBitmapData("asset.llk.boxNum");
         _mc = ComponentFactory.Instance.creat("asset.llk.boxShine");
         _scoreSp = new Sprite();
         _filter = new UIFilter();
         _mc.x = 20;
         _mc.y = 20;
         _mc.gotoAndPlay(1);
         _scoreSp.x = -5;
         _scoreSp.y = 23;
         addChild(_icon);
         addChild(_mc);
         addChild(_scoreSp);
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
         _icon.setFrame(_level + 1);
         _data = model.info.boxList[_level];
         if(_data)
         {
            if(_flag == false)
            {
               NumberViewUtils.refreshValue(_data.score,_scoreSp,_scoreRes,14,19,10,14,"0123456789");
               if(_data.score > 9999)
               {
                  _scoreSp.x = -5;
               }
               else if(_data.score > 999)
               {
                  _scoreSp.x = 0;
               }
               else
               {
                  _scoreSp.x = 5;
               }
               _flag = true;
            }
            if(_data.isGet)
            {
               state = 2;
            }
            else if(_data.score > 0)
            {
               if(_data.score > model.info.score)
               {
                  state = 3;
               }
               else
               {
                  state = 1;
               }
            }
            else
            {
               state = 3;
            }
         }
         else
         {
            state = 3;
         }
      }
      
      private function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         switch(_state - 1)
         {
            case 0:
               buttonMode = true;
               _mc.visible = true;
               break;
            case 1:
               _filter.setGrayFilter(this);
            case 2:
               buttonMode = false;
               _mc.visible = false;
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(_state == 1)
         {
            LlkManager.llkGetScoreReward(_level);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function get model() : LlkModel
      {
         return LlkManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _data = null;
         if(_filter)
         {
            _filter.setNormalFilter(this);
         }
         _filter = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_scoreRes)
         {
            _scoreRes.dispose();
         }
         _scoreRes = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeAllChildren(_scoreSp);
         _scoreSp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

