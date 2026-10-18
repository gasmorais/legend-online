package consortia.view.minos.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.minos.item.MinosRankItem;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.MinosManager;
   import mvc.module.minos.MinosLevelInfo;
   import mvc.module.minos.MinosModel;
   import mvc.module.minos.MinosRankInfo;
   import utils.LogicUtils;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.HRollItemPanel;
   
   public class MinosEnterViewUI extends Sprite
   {
      
      protected var _bigbg:Bitmap;
      
      protected var _rightInfo:Image;
      
      protected var _rankMbg:MutipleImage;
      
      protected var _title:Bitmap;
      
      protected var _topInfoTxt2:FilterFrameText;
      
      protected var _enterTopLeft:MinosTopLeftUI;
      
      protected var _lightm:Bitmap;
      
      protected var _toprt:FilterFrameText;
      
      protected var _toprp1:FilterFrameText;
      
      protected var _toprp2:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _myRankTxt:FilterFrameText;
      
      private var _myFeatTxt:FilterFrameText;
      
      private var _rankItemList:Array = [];
      
      private var _itemList:Array = [];
      
      private var _rollPanel:HRollItemPanel;
      
      public function MinosEnterViewUI()
      {
         super();
         initView();
         initData();
      }
      
      protected function initView() : void
      {
         _bigbg = ComponentFactory.Instance.creatBitmap("asset.minos.bigbg");
         _rightInfo = ComponentFactory.Instance.creatComponentByStylename("ui.minos.rightInfo");
         _rankMbg = ComponentFactory.Instance.creatComponentByStylename("ui.minos.rankMbg");
         _title = ComponentFactory.Instance.creatBitmap("asset.minos.title");
         _topInfoTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.minos.topInfoTxt2");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("ui.minos.rank.vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ui.minos.rank.scrollPanel");
         _enterTopLeft = ComponentFactory.Instance.creatCustomObject("ui.minos.enterTopLeft");
         _lightm = ComponentFactory.Instance.creatBitmap("asset.minos.lightm");
         _toprt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.toprt");
         _toprp1 = ComponentFactory.Instance.creatComponentByStylename("ui.minos.toprp1");
         _toprp2 = ComponentFactory.Instance.creatComponentByStylename("ui.minos.toprp2");
         _myRankTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.myRankTxt");
         _myFeatTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.featTxt");
         _rollPanel = new HRollItemPanel();
         _rollPanel.initParams("ui.minos.lvHbox","ui.minos.mainpreBtn","ui.minos.mainnextBtn",2,270,463);
         addChild(_bigbg);
         addChild(_rightInfo);
         addChild(_rankMbg);
         addChild(_title);
         addChild(_topInfoTxt2);
         addChild(_enterTopLeft);
         addChild(_lightm);
         addChild(_toprt);
         addChild(_toprp1);
         addChild(_toprp2);
         addChild(_rollPanel);
         addChild(_scrollPanel);
         addChild(_myRankTxt);
         addChild(_myFeatTxt);
         _rollPanel.maskWd = 675;
         _topInfoTxt2.text = LanguageMgr.GetTranslation("minos.enter.topInfo");
         _myRankTxt.text = LanguageMgr.GetTranslation("apex.rank.str7");
         _myFeatTxt.text = "0";
         _scrollPanel.setView(_vbox);
      }
      
      public function initData() : void
      {
         var _loc1_:MinosCardUI = null;
         var _loc3_:int = 0;
         var _loc4_:Array = TempleteManager.instance.minosLevelCate.getAllLevels();
         var _loc2_:int = int(_loc4_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new MinosCardUI();
            _loc1_.temp = _loc4_[_loc3_];
            _itemList[_loc3_] = _loc1_;
            _loc3_++;
         }
         _rollPanel.updateList(_itemList);
      }
      
      public function updateCardReward() : void
      {
         for each(var _loc1_:MinosCardUI in _itemList)
         {
            _loc1_.updateRewardState();
         }
      }
      
      public function refreshItemList() : void
      {
         var _loc1_:MinosCardUI = null;
         var _loc3_:MinosLevelInfo = null;
         var _loc4_:int = 0;
         _enterTopLeft.updateView();
         var _loc2_:int = int(_itemList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = _itemList[_loc4_];
            _loc1_.updateView();
            if(model.mapLvInfoDic[_loc4_ + 1] != null)
            {
               _loc3_ = model.mapLvInfoDic[_loc4_ + 1];
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            if(_loc3_.killNpc == _loc3_.npcMax && _loc3_.killBoss == _loc3_.bossMax)
            {
               _toprt.text = LanguageMgr.GetTranslation("ui.minos.topProMax");
               _toprp1.text = "";
               _toprp2.text = "";
            }
            else
            {
               _toprt.text = LanguageMgr.GetTranslation("ui.minos.topProTitle",_loc3_.id);
               _toprp1.text = LanguageMgr.GetTranslation("ui.minos.topProNpc",_loc3_.killNpc,_loc3_.npcMax);
               _toprp2.text = LanguageMgr.GetTranslation("ui.minos.topProBoss",_loc3_.killBoss,_loc3_.bossMax);
            }
         }
      }
      
      private function get model() : MinosModel
      {
         return MinosManager.ins.model;
      }
      
      public function updateRankList(param1:Array) : void
      {
         var _loc2_:MinosRankItem = null;
         var _loc3_:MinosRankInfo = null;
         var _loc7_:int = 0;
         _vbox.removeAllChild();
         if(!param1 || param1.length == 0)
         {
            return;
         }
         var _loc8_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         _vbox.beginChanges();
         var _loc4_:int = int(param1.length);
         var _loc6_:int = -1;
         var _loc5_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            if(_loc7_ < _rankItemList.length)
            {
               _loc2_ = _rankItemList[_loc7_];
            }
            else
            {
               _loc2_ = new MinosRankItem();
               _rankItemList.push(_loc2_);
            }
            _loc3_ = param1[_loc7_];
            _loc3_.rank = _loc7_ + 1;
            _loc2_.data = _loc3_;
            _vbox.addChild(_loc2_);
            if(_loc3_.userId == _loc8_)
            {
               _loc6_ = int(_loc3_.rank);
               _loc5_ = int(_loc3_.feat);
            }
            _loc7_++;
         }
         if(_loc6_ == -1)
         {
            _myRankTxt.text = LanguageMgr.GetTranslation("apex.rank.str7");
         }
         else
         {
            _myRankTxt.text = "" + _loc6_;
         }
         _myFeatTxt.text = "" + _loc5_;
         _vbox.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bigbg);
         _bigbg = null;
         LogicUtils.disposeDisplayCollection(_rankItemList);
         _rankItemList = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_rightInfo);
         _rightInfo = null;
         ObjectUtils.disposeObject(_rankMbg);
         _rankMbg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_topInfoTxt2);
         _topInfoTxt2 = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_enterTopLeft);
         _enterTopLeft = null;
         ObjectUtils.disposeObject(_lightm);
         _lightm = null;
         ObjectUtils.disposeObject(_toprt);
         _toprt = null;
         ObjectUtils.disposeObject(_toprp1);
         _toprp1 = null;
         ObjectUtils.disposeObject(_toprp2);
         _toprp2 = null;
         ObjectUtils.disposeObject(_myRankTxt);
         _myRankTxt = null;
         ObjectUtils.disposeObject(_myFeatTxt);
         _myFeatTxt = null;
         ObjectUtils.disposeObject(_rollPanel);
         _rollPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

