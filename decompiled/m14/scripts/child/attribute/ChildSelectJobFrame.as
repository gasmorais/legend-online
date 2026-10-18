package child.attribute
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildSender;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   
   public class ChildSelectJobFrame extends Frame
   {
      
      private var _data:ChildData;
      
      private var _boxList:Vector.<ChildSelectJobItem>;
      
      private var _itemContainer:Sprite;
      
      private var _scaleBg:ScaleBitmapImage;
      
      private var _sureBtn:IconButton;
      
      private var _currSelectedJob:int = 1;
      
      public function ChildSelectJobFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildSelectJobItem = null;
         _boxList = new Vector.<ChildSelectJobItem>();
         _itemContainer = new Sprite();
         _loc2_ = 1;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("child.ChildSelectJobItem");
            _loc1_.job = _loc2_;
            _itemContainer.addChild(_loc1_);
            _boxList.push(_loc1_);
            _loc1_.x = (_loc2_ - 1) * 235;
            _loc1_.addEventListener("click",__clickHandler);
            _loc2_++;
         }
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("child.childSelectedJob.scaleBg");
         _sureBtn = ComponentFactory.Instance.creatComponentByStylename("child.childSelectJob.sureBtn");
         addToContent(_itemContainer);
         addToContent(_scaleBg);
         addToContent(_sureBtn);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ChildSelectJobItem = null;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = _boxList[_loc4_];
            _loc2_.selected = false;
            _loc4_++;
         }
         var _loc3_:ChildSelectJobItem = param1.currentTarget as ChildSelectJobItem;
         _loc3_.selected = true;
         _currSelectedJob = _loc3_.job;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_sureBtn)
         {
            _sureBtn.addEventListener("click",__sureBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_sureBtn)
         {
            _sureBtn.removeEventListener("click",__sureBtnHandler);
         }
      }
      
      private function __sureBtnHandler(param1:MouseEvent) : void
      {
         ChildSender.applyChild(_currSelectedJob);
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function clearItem() : void
      {
         var _loc1_:ChildSelectJobItem = null;
         if(_boxList)
         {
            while(_boxList.length > 0)
            {
               _loc1_ = _boxList.pop();
               _loc1_.removeEventListener("click",__clickHandler);
               ObjectUtils.disposeObject(_loc1_);
            }
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         clearItem();
         ObjectUtils.disposeObject(_itemContainer);
         _itemContainer = null;
         ObjectUtils.disposeObject(_sureBtn);
         _sureBtn = null;
         ObjectUtils.disposeObject(_scaleBg);
         _scaleBg = null;
         _data = null;
         _boxList = null;
         super.dispose();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

