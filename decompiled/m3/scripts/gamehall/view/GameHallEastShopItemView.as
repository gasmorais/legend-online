package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.gamehall.GameHallEastShopInfo;
   import yishi.view.community.BaseItemView;
   
   public class GameHallEastShopItemView extends Sprite
   {
      
      private var _bg:Image;
      
      private var _goodsIcon:BaseItemView;
      
      private var _goodsName:FilterFrameText;
      
      private var _hasGet:FilterFrameText;
      
      private var _hasGetNum:FilterFrameText;
      
      private var _remain:FilterFrameText;
      
      private var _remainNum:FilterFrameText;
      
      private var _resetTxt:FilterFrameText;
      
      private var _data:GameHallEastShopInfo;
      
      private var _setHasGetVisible:Boolean = true;
      
      public function GameHallEastShopItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopItemView.bg");
         _goodsIcon = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallEastShopItemView.goodsIcon");
         _goodsName = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopItemView.goodsName");
         _hasGet = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopItemView.hasGet");
         _hasGetNum = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopItemView.hasGetNum");
         _remain = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopItemView.remain");
         _remainNum = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopItemView.remainNum");
         _resetTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopItemView.resetTxt");
         addChild(_bg);
         addChild(_goodsIcon);
         addChild(_goodsName);
         addChild(_hasGet);
         addChild(_hasGetNum);
         addChild(_remain);
         addChild(_remainNum);
         addChild(_resetTxt);
         _hasGet.text = LanguageMgr.GetTranslation("Task.view.GoodsItem.hasOwnTxt.text");
         _remain.text = LanguageMgr.GetTranslation("battle.view.buffer.BufferListItemTip.turnText01");
         _resetTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallEastShopFrame.resetTxt");
         _resetTxt.visible = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_goodsIcon);
         _goodsIcon = null;
         ObjectUtils.disposeObject(_goodsName);
         _goodsName = null;
         ObjectUtils.disposeObject(_hasGet);
         _hasGet = null;
         ObjectUtils.disposeObject(_hasGetNum);
         _hasGetNum = null;
         ObjectUtils.disposeObject(_remain);
         _remain = null;
         ObjectUtils.disposeObject(_remainNum);
         _remainNum = null;
         ObjectUtils.disposeObject(_resetTxt);
         _resetTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      public function set setHasGetVisible(param1:Boolean) : void
      {
         _setHasGetVisible = param1;
      }
      
      public function set data(param1:GameHallEastShopInfo) : void
      {
         _data = param1;
         if(_data)
         {
            refreshView();
         }
         else
         {
            clear();
         }
      }
      
      private function clear() : void
      {
         _goodsIcon.data = null;
         _resetTxt.visible = false;
         _goodsName.text = "";
         _hasGetNum.text = "";
         _remainNum.text = "";
      }
      
      private function refreshView() : void
      {
         if(_data.goodsInfo && _data.goodsInfo.templateInfo)
         {
            _goodsIcon.data = _data.goodsInfo;
            _goodsName.text = _data.goodsInfo.templateInfo.TemplateName;
         }
         if(_setHasGetVisible)
         {
            _hasGet.visible = true;
            _hasGetNum.visible = true;
            _remain.text = LanguageMgr.GetTranslation("battle.view.buffer.BufferListItemTip.turnText01");
            _remain.x = 155;
         }
         else
         {
            _hasGet.visible = false;
            _hasGetNum.visible = false;
            _remain.text = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.numberText");
            _remain.x = 140;
         }
         if(_data.isShow == 1)
         {
            _resetTxt.visible = true;
         }
         else
         {
            _resetTxt.visible = false;
         }
         _hasGetNum.text = _data.hasGetNumber.toString();
         _remainNum.text = _data.remainNumber.toString();
      }
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

