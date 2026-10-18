package stararea
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.StarareaModel;
   import yishi.utils.FlickerHelper;
   
   public class StarareaPointItem extends Component
   {
      
      private var _starId:int;
      
      private var mc:MovieClip;
      
      private var _txtId:FilterFrameText;
      
      private var _isInFrog:Boolean = false;
      
      private var _type:int = -2;
      
      private var _hitAreaSp:Sprite;
      
      private var _isLight:Boolean;
      
      public function StarareaPointItem(param1:MovieClip, param2:int, param3:int)
      {
         super();
         buttonMode = true;
         mc = param1;
         mc.nodeBg.light.visible = false;
         x = param1.x + param2;
         y = param1.y + param3;
         param1.x = 0;
         param1.y = 0;
         addChild(param1);
         param1.mouseChildren = param1.mouseEnabled = false;
         this.mouseEnabled = false;
         _hitAreaSp = new Sprite();
         _hitAreaSp.graphics.beginFill(16711680,0);
         _hitAreaSp.graphics.drawCircle(0,0,16);
         _hitAreaSp.graphics.endFill();
         addChild(_hitAreaSp);
         starId = int(param1.name.slice(4));
         _txtId = new FilterFrameText();
         _txtId.textColor = 16777215;
         _txtId.text = starId + "";
         if(!model.starViewMap.containsKey(starId))
         {
            model.starViewMap.put(starId,new Point(x,y));
         }
         initEvent();
      }
      
      public function set isLight(param1:Boolean) : void
      {
         _isLight = param1;
         mc.nodeBg.light.visible = _isLight;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _type = param1;
         isLight = false;
         if(_type == -1)
         {
            mc.gotoAndStop(1);
            FlickerHelper.clearFilcker(this);
         }
         else
         {
            _loc2_ = 50;
            _loc3_ = _type;
            if(_type >= _loc2_)
            {
               _loc3_ -= _loc2_;
               _loc4_ = true;
            }
            if(_loc3_ > mc.totalFrames)
            {
               mc.gotoAndStop(1);
               FlickerHelper.clearFilcker(this);
            }
            else
            {
               if(_loc4_)
               {
                  if(model.pointFlashArr[_starId] == 1)
                  {
                     FlickerHelper.setFilcker3(this);
                     model.pointFlashArr[_starId] = 2;
                  }
               }
               else
               {
                  FlickerHelper.setFilcker(this);
               }
               mc.gotoAndStop(_loc3_ + 1);
            }
         }
      }
      
      private function initEvent() : void
      {
         _hitAreaSp.buttonMode = true;
         _hitAreaSp.addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         _hitAreaSp.removeEventListener("click",onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(type > 50 && !_isLight)
         {
            return;
         }
         StarareaManager.instance.sendGetAward(starId);
      }
      
      public function set isInFrog(param1:Boolean) : void
      {
         _isInFrog = param1;
         if(_isInFrog)
         {
            mc.nodeBg.gotoAndStop(1);
         }
         else
         {
            mc.nodeBg.gotoAndStop(2);
         }
      }
      
      public function get isInFrog() : Boolean
      {
         return _isInFrog;
      }
      
      public function get model() : StarareaModel
      {
         return StarareaManager.instance.model;
      }
      
      public function get starId() : int
      {
         return _starId;
      }
      
      public function set starId(param1:int) : void
      {
         _starId = param1;
      }
      
      override public function dispose() : void
      {
         FlickerHelper.clearFilcker(this);
         removeEvent();
         ObjectUtils.disposeObject(mc);
         mc = null;
         ObjectUtils.disposeObject(_txtId);
         _txtId = null;
         ObjectUtils.disposeObject(_hitAreaSp);
         _hitAreaSp = null;
         super.dispose();
      }
   }
}

