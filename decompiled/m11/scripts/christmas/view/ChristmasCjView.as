package christmas.view
{
   import christmas.item.ChristmasCjItem;
   import christmas.item.ChristmascjSonItem1;
   import christmas.item.ChristmascjSonItem2;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import utils.LogicUtils;
   import yishi.datas.templates.ChristmasAchievementsTempInfo;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.HRollItemPanel;
   
   public class ChristmasCjView extends Sprite
   {
      
      protected var _titleBg:Bitmap;
      
      protected var _title:Bitmap;
      
      protected var _botoomBg:Bitmap;
      
      protected var _cjAllBtn:IconButton;
      
      protected var _cjPanel:ScrollPanel;
      
      private var _panelList:SimpleTileList;
      
      protected var _cjbtomTTTxt:FilterFrameText;
      
      protected var _cjDesbtomTxt:FilterFrameText;
      
      private var _hPanel:HRollItemPanel;
      
      private var _itemList:Array = [];
      
      private var _dic:Dictionary = new Dictionary();
      
      private var _rewardlist:Array = [];
      
      private var _timeBg:Bitmap;
      
      protected var _timeTxt:FilterFrameText;
      
      public function ChristmasCjView()
      {
         super();
         initView();
         initData();
         addEvent();
      }
      
      protected function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.Christmas.chengjiu.titleBg");
         _title = ComponentFactory.Instance.creatBitmap("asset.Christmas.chengjiu.title");
         _botoomBg = ComponentFactory.Instance.creatBitmap("asset.Christmas.chengjiu.botoomBg");
         _cjAllBtn = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjAllBtn");
         _cjPanel = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjPanel");
         _cjbtomTTTxt = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjbtomTTTxt");
         _cjDesbtomTxt = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjDesbtomTxt");
         _hPanel = ComponentFactory.Instance.creatCustomObject("ui.christmas.cjRollPanel");
         _hPanel.initParams("ui.christmas.cjRollPanel.HBox","ui.christmas.cjpreBtn","ui.christmas.cjnextBtn",5,138,196,5);
         _panelList = ComponentFactory.Instance.creatCustomObject("ui.christmas.cjSimpleTileList",[2]);
         _timeBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasFrame.timeBg");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.CjTimeTxt");
         addChild(_titleBg);
         addChild(_title);
         addChild(_timeBg);
         addChild(_timeTxt);
         addChild(_botoomBg);
         addChild(_cjAllBtn);
         addChild(_cjPanel);
         addChild(_cjbtomTTTxt);
         addChild(_cjDesbtomTxt);
         addChild(_hPanel);
         _cjPanel.setView(_panelList);
         _hPanel.maskWd = 712;
         _timeBg.x = 330;
         _timeBg.y = 102;
         _timeTxt.htmlText = LanguageMgr.GetTranslation("ChristmasFrame.timeTxt.text",model.openTimeStr,model.stopTimeStr);
         _cjDesbtomTxt.text = LanguageMgr.GetTranslation("christmasChengjiuFrame.desbtomTxt.text");
         _cjbtomTTTxt.htmlText = LanguageMgr.GetTranslation("ChristmasCjView.cjbtomTTTxt.text",model.score);
      }
      
      private function initData() : void
      {
         var _loc13_:ChristmasAchievementsTempInfo = null;
         var _loc8_:Array = null;
         var _loc2_:ChristmasCjItem = null;
         var _loc11_:ChristmasActivitiesTempInfo = null;
         var _loc4_:ChristmascjSonItem1 = null;
         var _loc3_:ChristmascjSonItem2 = null;
         var _loc9_:Array = [];
         var _loc1_:Dictionary = new Dictionary();
         var _loc6_:Array = TempleteManager.instance.christmasAchievementsTempCate.getTaskList();
         var _loc10_:int = int(_loc6_.length);
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc10_)
         {
            _loc13_ = _loc6_[_loc5_];
            _loc8_ = _loc1_[_loc13_.Type];
            if(_loc8_ == null)
            {
               _loc1_[_loc13_.Type] = [];
               _loc9_.push(_loc13_.Type);
               _loc8_ = _loc1_[_loc13_.Type];
            }
            _loc8_.push(_loc13_);
            _loc5_++;
         }
         _loc10_ = int(_loc9_.length);
         _panelList.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc10_)
         {
            _loc2_ = new ChristmasCjItem();
            _loc2_.taskList = _loc1_[_loc9_[_loc5_]];
            _itemList.push(_loc2_);
            _panelList.addChild(_loc2_);
            _loc5_++;
         }
         _panelList.commitChanges();
         _cjPanel.invalidateViewport();
         _rewardlist = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(6);
         var _loc7_:Array = [];
         _loc10_ = int(_rewardlist.length);
         var _loc12_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc10_)
         {
            _loc11_ = _rewardlist[_loc5_];
            if(_loc11_.SonType == 0)
            {
               _loc4_ = new ChristmascjSonItem1();
               _loc4_.tempInfo = _loc11_;
               _loc7_.push(_loc4_);
               _dic[_loc11_.Id] = _loc4_;
            }
            else
            {
               _loc3_ = new ChristmascjSonItem2();
               _loc3_.tempInfo = _loc11_;
               _loc7_.push(_loc3_);
               _dic[_loc11_.Id] = _loc3_;
            }
            _loc5_++;
         }
         _hPanel.updateList(_loc7_);
      }
      
      public function updateView() : void
      {
         for each(var _loc1_:ChristmasCjItem in _itemList)
         {
            _loc1_.updateView();
         }
      }
      
      private function addEvent() : void
      {
         ChristmasManager.instance.addEventListener("EVENT_UPDATE",updateInfoHandler);
         _cjAllBtn.addEventListener("click",__allBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         ChristmasManager.instance.removeEventListener("EVENT_UPDATE",updateInfoHandler);
         _cjAllBtn.removeEventListener("click",__allBtnClickHandler);
      }
      
      private function __allBtnClickHandler(param1:MouseEvent) : void
      {
         ChristmasManager.instance.opRequest(14);
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc3_:ChristmasActivitiesTempInfo = null;
         var _loc4_:int = 0;
         _cjbtomTTTxt.htmlText = LanguageMgr.GetTranslation("ChristmasCjView.cjbtomTTTxt.text",model.score);
         var _loc2_:int = int(_rewardlist.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _rewardlist[_loc4_];
            _dic[_loc3_.Id].refreshView();
            _loc4_++;
         }
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_botoomBg);
         _botoomBg = null;
         ObjectUtils.disposeObject(_cjAllBtn);
         _cjAllBtn = null;
         ObjectUtils.disposeObject(_cjPanel);
         _cjPanel = null;
         ObjectUtils.disposeObject(_cjbtomTTTxt);
         _cjbtomTTTxt = null;
         ObjectUtils.disposeObject(_cjDesbtomTxt);
         _cjDesbtomTxt = null;
         ObjectUtils.disposeObject(_hPanel);
         _hPanel = null;
         ObjectUtils.disposeObject(_panelList);
         _panelList = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         LogicUtils.disposeDisplayCollection(_dic);
         _dic = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _rewardlist = null;
      }
   }
}

