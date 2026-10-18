package sqmemory.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SqMemoryManger;
   import sqmemory.item.SqmemoryItem;
   import yishi.manager.FrameControllerManager;
   
   public class SqmemoryPage8 extends SqmemoryBasePage
   {
      
      private var _leftVbox:VBox;
      
      private var _rightVbox:VBox;
      
      private var _endTxt:FilterFrameText;
      
      private var _btn:IconButton;
      
      public function SqmemoryPage8()
      {
         super();
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         _leftVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page2.vbox");
         _rightVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page1.vbox");
         _endTxt = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.page8R1");
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.sqmemory.page8Btn");
         addChild(_leftVbox);
         addChild(_rightVbox);
         addChild(_endTxt);
         addChild(_btn);
         _endTxt.text = LanguageMgr.GetTranslation("sqMemory.note.legend8");
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("sqmemory",1);
      }
      
      private function initData() : void
      {
         var _loc2_:SqmemoryItem = null;
         var _loc6_:String = null;
         var _loc3_:* = null;
         var _loc1_:String = null;
         var _loc5_:String = SqMemoryManger.Instance.userDataInfo.legendInfo;
         var _loc4_:Array = _loc5_.split("|");
         _leftVbox.beginChanges();
         _loc6_ = _loc4_[4];
         _loc2_ = createNote(_loc6_,["sqMemory.note.legend4"],[2]);
         if(_loc2_)
         {
            _loc2_.changeDesHeight(300);
            _leftVbox.addChild(_loc2_);
         }
         _loc6_ = _loc4_[5];
         _loc2_ = createNote(_loc6_,["sqMemory.note.legend5"],[2]);
         if(_loc2_)
         {
            _leftVbox.addChild(_loc2_);
         }
         _leftVbox.commitChanges();
         _rightVbox.beginChanges();
         _loc6_ = _loc4_[6];
         _loc2_ = createNote(_loc6_,["sqMemory.note.legend6","sqMemory.note.legend6_N"],[2,2]);
         if(_loc2_)
         {
            _rightVbox.addChild(_loc2_);
         }
         _loc2_ = new SqmemoryItem(2);
         _loc1_ = LanguageMgr.GetTranslation("sqMemory.note.legend7");
         _loc2_.updateView(_loc1_);
         _rightVbox.addChild(_loc2_);
         _rightVbox.commitChanges();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_leftVbox);
         ObjectUtils.disposeObject(_leftVbox);
         _leftVbox = null;
         ObjectUtils.disposeAllChildren(_rightVbox);
         ObjectUtils.disposeObject(_rightVbox);
         _rightVbox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

