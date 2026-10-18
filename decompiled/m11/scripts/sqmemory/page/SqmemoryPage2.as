package sqmemory.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.SqMemoryManger;
   import sqmemory.item.SqmemoryItem;
   
   public class SqmemoryPage2 extends SqmemoryBasePage
   {
      
      private var _leftVbox:VBox;
      
      private var _rightVbox:VBox;
      
      public function SqmemoryPage2()
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
         var _loc7_:Bitmap = null;
         var _loc4_:Bitmap = null;
         var _loc8_:String = null;
         var _loc3_:Array = null;
         var _loc1_:String = null;
         var _loc6_:String = SqMemoryManger.Instance.userDataInfo.friendShipInfo;
         var _loc5_:Array = _loc6_.split("|");
         _leftVbox.beginChanges();
         _loc8_ = _loc5_[0];
         _loc2_ = createNote(_loc8_,["sqMemory.note.friend1_Y","sqMemory.note.friend1_N"],[1,2],true);
         _loc7_ = ComponentFactory.Instance.creatBitmap("asset.sqmemory.consotiaFlg");
         _loc2_.addImage(_loc7_);
         _leftVbox.addChild(_loc2_);
         _loc4_ = ComponentFactory.Instance.creatBitmap("asset.sqmemory.line");
         _leftVbox.addChild(_loc4_);
         _loc8_ = _loc5_[1];
         _loc2_ = createNote(_loc8_,["sqMemory.note.friend2_Y","sqMemory.note.friend2_N"],[2,2]);
         _loc7_ = ComponentFactory.Instance.creatBitmap("asset.sqmemory.partner");
         _loc2_.addImage(_loc7_);
         _leftVbox.addChild(_loc2_);
         _loc4_ = ComponentFactory.Instance.creatBitmap("asset.sqmemory.line");
         _leftVbox.addChild(_loc4_);
         _loc8_ = _loc5_[2];
         _loc2_ = new SqmemoryItem(2);
         _loc3_ = _loc8_.split(",");
         _loc3_.unshift("sqMemory.note.friend3");
         _loc1_ = LanguageMgr.GetTranslation.apply(this,_loc3_);
         _loc2_.updateView(_loc1_);
         _leftVbox.addChild(_loc2_);
         _leftVbox.commitChanges();
         _rightVbox.beginChanges();
         _loc8_ = _loc5_[3];
         _loc2_ = createNote(_loc8_,["sqMemory.note.friend4_Y","sqMemory.note.friend4_N"],[1,2],true);
         _loc2_.changeDesHeight(324);
         _rightVbox.addChild(_loc2_);
         _loc8_ = _loc5_[4];
         _loc2_ = createNote(_loc8_,["sqMemory.note.friend5_Y","sqMemory.note.friend5_N"],[2,2]);
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

