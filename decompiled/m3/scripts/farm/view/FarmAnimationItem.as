package farm.view
{
   import chat.datas.ChatData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.manager.NotificationManager;
   
   public class FarmAnimationItem
   {
      
      private var _animation:MovieClip;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _value0:int;
      
      private var _value1:int;
      
      private var _parent:DisplayObjectContainer;
      
      private var _uint:uint;
      
      private var _userName:String;
      
      public function FarmAnimationItem(param1:DisplayObjectContainer, param2:int, param3:int, param4:int, param5:int, param6:String)
      {
         super();
         this._parent = param1;
         this._x = param2;
         this._y = param3;
         this._value0 = param4;
         this._value1 = param5;
         this._userName = param6;
         initView();
      }
      
      private function initView() : void
      {
         _animation = ComponentFactory.Instance.creatCustomObject("farm.randomMc");
         _animation.gotoAndPlay(1);
         _animation.addEventListener("ANIMATION_OVER",onPlayerOver);
         _animation.x = _x;
         _animation.y = _y;
         this._parent.addChild(_animation);
      }
      
      private function onPlayerOver(param1:Event) : void
      {
         _animation.removeEventListener("ANIMATION_OVER",onPlayerOver);
         _animation.errect0.gotoAndStop(1);
         _animation.errect1.gotoAndStop(1);
         if(_value0 > 0)
         {
            _animation.mc0.gotoAndStop(_value0 + 1);
         }
         else
         {
            _animation.mc0.gotoAndStop(1);
            _animation.errect0.gotoAndPlay(2);
         }
         if(_value1 > 0)
         {
            _animation.mc1.gotoAndStop(_value1 + 1);
         }
         else
         {
            _animation.mc1.gotoAndStop(1);
            _animation.errect1.gotoAndPlay(2);
         }
         showChatMsg();
         clearTimeout(_uint);
         _uint = setTimeout(dispose,2000);
      }
      
      private function showChatMsg() : void
      {
         var _loc1_:String = null;
         var _loc4_:Number = NaN;
         var _loc3_:int = _value0 + _value1;
         if(_loc3_ == 0)
         {
            _loc4_ = Math.random();
            if(_loc4_ > 0.5)
            {
               _loc1_ = LanguageMgr.GetTranslation("farm.farmAnimationItem.tips0",_userName);
            }
            else
            {
               _loc1_ = LanguageMgr.GetTranslation("farm.farmAnimationItem.tips7",_userName);
            }
         }
         else if(_loc3_ == 1)
         {
            _loc1_ = LanguageMgr.GetTranslation("farm.farmAnimationItem.tips1",_userName);
         }
         else if(1 < _loc3_ && _loc3_ <= 6)
         {
            _loc1_ = LanguageMgr.GetTranslation("farm.farmAnimationItem.tips2",_userName,_loc3_);
            if(_value0 == 0 || _value1 == 0)
            {
               _loc4_ = Math.random();
               if(_loc4_ > 0.5)
               {
                  _loc1_ = LanguageMgr.GetTranslation("farm.farmAnimationItem.tips6",_userName,_loc3_);
               }
               else
               {
                  _loc1_ = LanguageMgr.GetTranslation("farm.farmAnimationItem.tips8",_userName,_loc3_);
               }
            }
         }
         else if(6 < _loc3_ && _loc3_ <= 9)
         {
            _loc1_ = LanguageMgr.GetTranslation("farm.farmAnimationItem.tips3",_userName,_loc3_);
         }
         else if(9 < _loc3_ && _loc3_ <= 11)
         {
            _loc1_ = LanguageMgr.GetTranslation("farm.farmAnimationItem.tips4",_userName,_loc3_);
         }
         else if(_loc3_ == 12)
         {
            _loc1_ = LanguageMgr.GetTranslation("farm.farmAnimationItem.tips5",_userName);
         }
         var _loc2_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc2_.channel = 3;
         _loc2_.msg = _loc1_;
         _loc2_.commit();
         NotificationManager.instance.sendNotification("ADD_CHAT",_loc2_);
      }
      
      public function dispose() : void
      {
         clearTimeout(_uint);
         if(_animation && _animation.parent)
         {
            _animation.parent.removeChild(_animation);
         }
         if(_animation)
         {
            ObjectUtils.disposeObject(_animation);
            _animation = null;
         }
         this._parent = null;
      }
   }
}

