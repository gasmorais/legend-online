package sqmemory.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.SqMemoryManger;
   import sqmemory.item.SqmemoryItem;
   
   public class SqmemoryPage7 extends SqmemoryBasePage
   {
      
      private var _leftVbox:VBox;
      
      private var _rightVbox:VBox;
      
      public function SqmemoryPage7()
      {
         super();
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _leftVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page2.vbox");
         _rightVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page1.vbox");
         addChild(_leftVbox);
         addChild(_rightVbox);
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
         _loc6_ = _loc4_[0];
         _loc2_ = createNote(_loc6_,["sqMemory.note.legend1"],[2]);
         if(_loc2_)
         {
            _leftVbox.addChild(_loc2_);
         }
         _loc6_ = _loc4_[1];
         _loc2_ = createNote(_loc6_,["sqMemory.note.legend2"],[1],true);
         if(_loc2_)
         {
            _leftVbox.addChild(_loc2_);
         }
         _leftVbox.commitChanges();
         _rightVbox.beginChanges();
         _loc2_ = new SqmemoryItem(2);
         _loc1_ = LanguageMgr.GetTranslation("sqMemory.note.legend3");
         _loc2_.updateView(_loc1_);
         _rightVbox.addChild(_loc2_);
         _loc6_ = _loc4_[2];
         _loc2_ = createNote(_loc6_,["sqMemory.note.legend3_Y_1"],[3]);
         if(_loc2_)
         {
            _rightVbox.addChild(_loc2_);
         }
         _loc6_ = _loc4_[3];
         _loc2_ = createNote(_loc6_,["sqMemory.note.legend3_Y_2"],[3]);
         if(_loc2_)
         {
            _rightVbox.addChild(_loc2_);
         }
         _loc2_ = new SqmemoryItem(3);
         _loc1_ = LanguageMgr.GetTranslation("sqMemory.note.legend3_Y_3");
         _loc2_.updateView(_loc1_);
         _rightVbox.addChild(_loc2_);
         _rightVbox.commitChanges();
      }
      
      public function dispose() : void
      {
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

