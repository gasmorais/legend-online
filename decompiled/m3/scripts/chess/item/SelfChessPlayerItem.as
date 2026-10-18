package chess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.chess.SelfChessPlayerInfo;
   import yishi.view.base.NumberBitmap;
   import yishi.view.base.ProgressPanel;
   
   public class SelfChessPlayerItem extends Component
   {
      
      public var _playerSelected:Bitmap;
      
      public var _playerBg:Bitmap;
      
      public var _playerGoldTxt:FilterFrameText;
      
      public var _playerLvTxt:FilterFrameText;
      
      public var _playerGold:Image;
      
      private var _data:SelfChessPlayerInfo;
      
      private var _nameTxt:GradientText;
      
      private var _hpBit:NumberBitmap;
      
      private var _hpProgress:ProgressPanel;
      
      public function SelfChessPlayerItem()
      {
         super();
         initView();
      }
      
      public function get data() : SelfChessPlayerInfo
      {
         return _data;
      }
      
      public function set data(param1:SelfChessPlayerInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _data = param1;
         if(_data)
         {
            _playerLvTxt.text = "" + _data.grade;
            _playerGoldTxt.text = "" + _data.gold;
            _nameTxt.text = "" + _data.name;
            if(_data.hp <= 0)
            {
               _hpBit.num = 0;
            }
            else
            {
               _hpBit.num = _data.hp;
            }
            _playerSelected.visible = _data.isSelf;
            _loc2_ = 100;
            _loc3_ = int(_data.hp);
            _hpProgress.progressValue(_loc3_,_loc2_);
            tipData = _data;
         }
      }
      
      private function initView() : void
      {
         _playerSelected = ComponentFactory.Instance.creatBitmap("asset.selfchess.playerSelected");
         _playerBg = ComponentFactory.Instance.creatBitmap("asset.selfchess.playerBg");
         _playerGoldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.playerGoldTxt");
         _playerLvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.playerLvTxt");
         _playerGold = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.playerGold");
         _hpBit = ComponentFactory.Instance.creatCustomObject("ui.selfchess.playerHpBitmap");
         _hpProgress = ComponentFactory.Instance.creatCustomObject("ui.selfchess.playerHpProgress");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.playerNameTxt");
         _hpBit.initParams(null,"asset.selfchess.red",18,22,15,18,"0123456789");
         _hpProgress.initView(null,"asset.selfchess.progressBar2",null);
         addChild(_playerSelected);
         addChild(_playerBg);
         addChild(_playerGoldTxt);
         addChild(_playerLvTxt);
         addChild(_playerGold);
         addChild(_hpBit);
         addChild(_hpProgress);
         addChild(_nameTxt);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_playerSelected);
         _playerSelected = null;
         ObjectUtils.disposeObject(_playerBg);
         _playerBg = null;
         ObjectUtils.disposeObject(_playerGoldTxt);
         _playerGoldTxt = null;
         ObjectUtils.disposeObject(_playerLvTxt);
         _playerLvTxt = null;
         ObjectUtils.disposeObject(_playerGold);
         _playerGold = null;
         ObjectUtils.disposeObject(_hpBit);
         _hpBit = null;
         ObjectUtils.disposeObject(_hpProgress);
         _hpProgress = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         super.dispose();
         _data = null;
      }
   }
}

