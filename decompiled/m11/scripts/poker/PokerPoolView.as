package poker
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.pet.CardMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.poker.PokerBoardInfo;
   import yishi.manager.PokerManager;
   
   public class PokerPoolView extends Component
   {
      
      private var _bottomNote:Bitmap;
      
      private var _chipPos:Array = [[-12,30],[150,30],[295,30],[-12,57],[150,57],[295,57]];
      
      private var _notePos:Array = [[-43,30],[126,30],[269,32],[-43,59],[126,59],[269,59]];
      
      private var _txtPos:Array = [[54,30],[224,30],[366,30],[54,57],[224,57],[366,57]];
      
      private var _cardPos:Array = [[0,0],[69,0],[137,0],[204,0],[271,0]];
      
      private var _container:Sprite;
      
      private var _cardSprite:Sprite;
      
      private var _poolChipsTxt:FilterFrameText;
      
      public function PokerPoolView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bottomNote = ComponentFactory.Instance.creatBitmap("asset.poker.bottomNote");
         _container = ComponentFactory.Instance.creatCustomObject("poker.poolSprite");
         _cardSprite = ComponentFactory.Instance.creatCustomObject("poker.poolCardSprite");
         _poolChipsTxt = ComponentFactory.Instance.creatComponentByStylename("poker.poolChipsTxt");
         addChild(_bottomNote);
         addChild(_poolChipsTxt);
         _poolChipsTxt.x = 188;
         _poolChipsTxt.y = 2;
         addChild(_container);
         addChild(_cardSprite);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function refreshView() : void
      {
         var _loc4_:Image = null;
         var _loc7_:FilterFrameText = null;
         var _loc1_:FilterFrameText = null;
         var _loc8_:PokerCardView = null;
         var _loc2_:CardMsg = null;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:PokerBoardInfo = PokerManager.instance.boardInfo;
         _poolChipsTxt.text = _loc3_.totalPot + "";
         ObjectUtils.disposeAllChildren(_cardSprite);
         _loc9_ = 0;
         while(_loc9_ < _loc3_.cardArr.length)
         {
            _loc2_ = _loc3_.cardArr[_loc9_] as CardMsg;
            _loc8_ = new PokerCardView(_loc2_.suit,_loc2_.rank);
            _loc8_.x = _cardPos[_loc9_][0];
            _loc8_.y = _cardPos[_loc9_][1];
            _cardSprite.addChild(_loc8_);
            _loc9_++;
         }
         if(_loc3_.bet != 0)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_container);
         _loc6_ = 0;
         while(_loc6_ < _loc3_.potArr.length)
         {
            _loc5_ = _loc3_.potArr[_loc6_] as int;
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("poker.poolPointBg");
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("poker.poolChipsNote");
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("poker.poolChipsTxt");
            _loc4_.width = 125;
            _loc4_.x = _chipPos[_loc6_][0];
            _loc4_.y = _chipPos[_loc6_][1];
            _loc7_.x = _notePos[_loc6_][0];
            _loc7_.y = _notePos[_loc6_][1];
            _loc1_.x = _txtPos[_loc6_][0];
            _loc1_.y = _txtPos[_loc6_][1];
            _loc7_.text = LanguageMgr.GetTranslation("poker.PokerPoolView.poolTxt" + _loc6_);
            _loc1_.text = _loc5_ + "";
            _container.addChild(_loc4_);
            _container.addChild(_loc7_);
            _container.addChild(_loc1_);
            _loc6_++;
         }
      }
      
      public function get poolChipsTxt() : FilterFrameText
      {
         return _poolChipsTxt;
      }
      
      public function get cardSprite() : Sprite
      {
         return _cardSprite;
      }
      
      public function removePool() : void
      {
         ObjectUtils.disposeAllChildren(_container);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bottomNote);
         _bottomNote = null;
         ObjectUtils.disposeAllChildren(_container);
         ObjectUtils.disposeObject(_container);
         _container = null;
         ObjectUtils.disposeAllChildren(_cardSprite);
         ObjectUtils.disposeObject(_cardSprite);
         _cardSprite = null;
         ObjectUtils.disposeObject(_poolChipsTxt);
         _poolChipsTxt = null;
         super.dispose();
      }
   }
}

