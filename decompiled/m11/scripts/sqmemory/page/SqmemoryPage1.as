package sqmemory.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.SqMemoryManger;
   import sqmemory.item.SqmemoryHalfSwf;
   import sqmemory.item.SqmemoryItem;
   import yishi.manager.PlayerManager;
   
   public class SqmemoryPage1 extends SqmemoryBasePage
   {
      
      private var _half:SqmemoryHalfSwf;
      
      private var _note1:SqmemoryItem;
      
      private var _rightVbox:VBox;
      
      public function SqmemoryPage1()
      {
         super();
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _half = ComponentFactory.Instance.creatCustomObject("sqmemory.item.SqmemoryHalfSwf");
         _note1 = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page1.note1");
         _rightVbox = ComponentFactory.Instance.creatCustomObject("ui.sqmemory.page1.vbox");
         addChild(_half);
         addChild(_note1);
         addChild(_rightVbox);
         _half.job = PlayerManager.instance.currentPlayerModel.playerInfo.job;
      }
      
      private function initData() : void
      {
         var _loc3_:SqmemoryItem = null;
         var _loc5_:Bitmap = null;
         var _loc7_:Bitmap = null;
         var _loc6_:int = 0;
         var _loc9_:String = SqMemoryManger.Instance.userDataInfo.beginInfo;
         var _loc4_:Array = _loc9_.split("|");
         var _loc8_:String = _loc4_.shift();
         var _loc2_:Array = _loc8_.split(",");
         _loc2_[0] = _loc2_[0].substr(0,10);
         _loc2_.unshift("sqMemory.note.adventure1");
         var _loc1_:String = LanguageMgr.GetTranslation.apply(this,_loc2_);
         _note1.updateView(_loc1_);
         _rightVbox.beginChanges();
         _loc8_ = _loc4_.shift();
         _loc3_ = createNote(_loc8_,["sqMemory.note.adventure2","sqMemory.note.adventure2_N"],[1,2],true);
         if(_loc3_)
         {
            _loc7_ = ComponentFactory.Instance.creatBitmap("asset.sqmemory.bossFlg");
            _loc3_.addImage(_loc7_);
            _rightVbox.addChild(_loc3_);
            _loc5_ = ComponentFactory.Instance.creatBitmap("asset.sqmemory.line");
            _rightVbox.addChild(_loc5_);
         }
         _loc3_ = new SqmemoryItem(2);
         _loc1_ = LanguageMgr.GetTranslation("sqMemory.note.adventure3");
         _loc3_.updateView(_loc1_);
         _rightVbox.addChild(_loc3_);
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc6_];
            _loc3_ = createNote(_loc8_,["sqMemory.note.adventure3_Y_" + (_loc6_ + 1),"sqMemory.note.adventure3_N_" + (_loc6_ + 1)],[3,3],true);
            _rightVbox.addChild(_loc3_);
            _loc6_++;
         }
         _loc5_ = ComponentFactory.Instance.creatBitmap("asset.sqmemory.line");
         _rightVbox.addChild(_loc5_);
         _rightVbox.commitChanges();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_half);
         _half = null;
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

