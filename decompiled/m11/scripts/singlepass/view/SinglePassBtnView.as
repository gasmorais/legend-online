package singlepass.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.singlepass.SinglePassCardInfo;
   
   public class SinglePassBtnView extends Sprite
   {
      
      private var _tollgateBtn:IconButton;
      
      private var _judge:Bitmap;
      
      private var _data:SinglePassCardInfo;
      
      private var _index:int;
      
      private var _enable:Boolean;
      
      private var _clickFunction:Function;
      
      public function SinglePassBtnView(param1:int)
      {
         super();
         _index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _tollgateBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.TollgateBtn" + _index);
         _judge = ComponentFactory.Instance.creatBitmap("asset.singlepass.BtnJudgeAsset");
         addChild(_tollgateBtn);
         addChild(_judge);
         _judge.visible = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_tollgateBtn);
         _tollgateBtn = null;
         ObjectUtils.disposeObject(_judge);
         _judge = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(_clickFunction != null)
         {
            _clickFunction(_data.tollgate);
         }
      }
      
      private function get showJudge() : Boolean
      {
         if(_data && _data.judge == 5)
         {
            return true;
         }
         return false;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _enable = param1;
         _tollgateBtn.enable = _enable;
         if(showJudge)
         {
            _judge.visible = _enable;
         }
      }
      
      public function set clickFunction(param1:Function) : void
      {
         _clickFunction = param1;
      }
      
      public function get data() : SinglePassCardInfo
      {
         return _data;
      }
      
      public function set data(param1:SinglePassCardInfo) : void
      {
         _data = param1;
         if(_data && _enable)
         {
            if(showJudge)
            {
               _judge.visible = true;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

