package sqmemory
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SqMemoryManger;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.NotificationManager;
   
   public class SqmemoryLabelFrame extends Frame
   {
      
      private var _itemList:Array = [];
      
      private var _leftVbox:VBox;
      
      private var _rightVbox:VBox;
      
      private var _groupBtn:SelectedButtonGroup;
      
      private var _confirmBtn:IconButton;
      
      public function SqmemoryLabelFrame()
      {
         super();
         initView();
         initEvent();
         _groupBtn.selectIndex = SqMemoryManger.Instance.currSelectIdx;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SelectedCheckButton = null;
         _leftVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.label.LVbox");
         _rightVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.label.RVbox");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.label.confirmBtn");
         addToContent(_leftVbox);
         addToContent(_rightVbox);
         addToContent(_confirmBtn);
         _groupBtn = new SelectedButtonGroup();
         _leftVbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.ThewCheckBtn");
            _groupBtn.addSelectItem(_loc1_);
            _itemList.push(_loc1_);
            _leftVbox.addChild(_loc1_);
            _loc2_++;
         }
         _leftVbox.commitChanges();
         _rightVbox.beginChanges();
         _loc2_ = 4;
         while(_loc2_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.ThewCheckBtn");
            _groupBtn.addSelectItem(_loc1_);
            _itemList.push(_loc1_);
            _rightVbox.addChild(_loc1_);
            _loc2_++;
         }
         _rightVbox.commitChanges();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _groupBtn.addEventListener("change",__tabChangeHandler);
         _confirmBtn.addEventListener("click",confirmHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _groupBtn.removeEventListener("change",__tabChangeHandler);
         _confirmBtn.removeEventListener("click",confirmHandler);
      }
      
      private function confirmHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("SqmemorySelectEvent");
         dispose();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SqMemoryManger.Instance.currSelectIdx = _groupBtn.selectIndex;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_groupBtn);
         _groupBtn = null;
         for each(var _loc1_:DisplayObject in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_leftVbox);
         _leftVbox = null;
         ObjectUtils.disposeObject(_rightVbox);
         _rightVbox = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         super.dispose();
      }
      
      public function show(param1:Array) : void
      {
         var _loc2_:SelectedCheckButton = null;
         var _loc4_:int = 0;
         titleText = LanguageMgr.GetTranslation("sqMemory.share.changeTitle");
         var _loc3_:Array = [];
         _loc3_.push("asset.sqmemory.loginT");
         _loc3_.push("asset.sqmemory.fightT");
         _loc3_.push("asset.sqmemory.killT");
         _loc3_.push("asset.sqmemory.victoryT");
         _loc3_.push("asset.sqmemory.fbT");
         _loc3_.push("asset.sqmemory.fashionT");
         _loc3_.push("asset.sqmemory.mountT");
         _loc3_.push("asset.sqmemory.consortiaT");
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = _itemList[_loc4_];
            _loc2_.text = LanguageMgr.GetTranslation(_loc3_[_loc4_] + param1[_loc4_]);
            _loc4_++;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

