package chess
{
   import chess.item.SelfChessKindItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.chess.SelfChessPlayerInfo;
   
   public class SelfChessKindListView extends Sprite
   {
      
      public var _leftVbox:VBox;
      
      private var _itemList:Array = [];
      
      private var _vSpace:int;
      
      private var _itemsHeight:int;
      
      private const MAX:int = 10;
      
      public function SelfChessKindListView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:SelfChessKindItem = null;
         var _loc2_:int = 0;
         _leftVbox = ComponentFactory.Instance.creatCustomObject("ui.selfchess.leftVbox");
         addChild(_leftVbox);
         _leftVbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("chess.item.SelfChessKindItem");
            _leftVbox.addChild(_loc1_);
            _itemList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _vSpace = _leftVbox.spacing;
         _vSpace += 62;
         _leftVbox.commitChanges();
      }
      
      public function refreshView() : void
      {
         var _loc3_:Dictionary = null;
         var _loc4_:Array = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:SelfChessPlayerInfo = SelfChessManager.Ins.model.selfInfo;
         if(_loc6_)
         {
            _loc3_ = SelfChessManager.Ins.model.selfJobNumDic;
            _loc4_ = [];
            for(var _loc5_:String in _loc3_)
            {
               _loc4_.push(int(_loc5_));
            }
            _loc4_.sort(16);
            _loc2_ = 0;
            while(_loc2_ < 10)
            {
               _loc1_ = int(_loc4_[_loc2_]);
               _itemList[_loc2_].job = _loc1_;
               _loc2_++;
            }
         }
         resize();
      }
      
      private function resize() : void
      {
         _itemsHeight = 0;
         for each(var _loc1_:SelfChessKindItem in _itemList)
         {
            if(_loc1_.visible)
            {
               _itemsHeight += _vSpace;
            }
         }
         this.y = 115 + (500 - _itemsHeight) * 0.5;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_leftVbox);
         _leftVbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _itemList = null;
      }
   }
}

