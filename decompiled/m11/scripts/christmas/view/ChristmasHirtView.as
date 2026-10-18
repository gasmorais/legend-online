package christmas.view
{
   import christmas.item.ChristmasHirtItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.templates.ChristmasLotteryTempInfo;
   import yishi.manager.ChristmasManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.TextAddBitmap;
   
   public class ChristmasHirtView extends Sprite
   {
      
      protected var _role:Bitmap;
      
      protected var _hirtMc:MovieClip;
      
      protected var _title:Bitmap;
      
      protected var _hirtPanel:ScrollPanel;
      
      protected var _hirtTimeTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _itemList:Array = [];
      
      private var _chargeTxt:FilterFrameText;
      
      private var _timeBg:Bitmap;
      
      private var _txtBit:TextAddBitmap;
      
      private var _hirtNumList:Array = [];
      
      private var _playUid:int;
      
      public function ChristmasHirtView()
      {
         super();
         initView();
         initData();
         updateView();
      }
      
      protected function initView() : void
      {
         _role = ComponentFactory.Instance.creatBitmap("asset.Christmas.hirt.role");
         _hirtMc = ComponentFactory.Instance.creatCustomObject("ui.christmas.hirtMc");
         _title = ComponentFactory.Instance.creatBitmap("asset.Christmas.hirt.title");
         _hirtPanel = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.hirtPanel");
         _vbox = ComponentFactory.Instance.creatCustomObject("ui.christmas.hirtPanelhirtpanelVbox");
         _hirtTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.hirtTimeTxt");
         _timeBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasFrame.timeBg");
         _chargeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.hirtChargeTxt");
         _txtBit = ComponentFactory.Instance.creatCustomObject("christmasGiftItem.hirtPtRechargtBit");
         _txtBit.initView("christmashitRecharge.pointNumTx","asset.core.SmallPointImg");
         addChild(_role);
         addChild(_hirtMc);
         addChild(_title);
         addChild(_hirtPanel);
         addChild(_timeBg);
         addChild(_hirtTimeTxt);
         addChild(_chargeTxt);
         addChild(_txtBit);
         _hirtPanel.setView(_vbox);
         _hirtMc.mc_turn.gotoAndStop(1);
         _hirtMc.mc_mask.gotoAndStop(1);
         _hirtMc.mc_mask.visible = false;
         _timeBg.x = 330;
         _timeBg.y = 102;
         _hirtTimeTxt.htmlText = LanguageMgr.GetTranslation("ChristmasFrame.timeTxt.text",model.openTimeStr,model.stopTimeStr);
      }
      
      private function initData() : void
      {
         var _loc1_:ChristmasHirtItem = null;
         var _loc5_:int = 0;
         var _loc8_:ChristmasLotteryTempInfo = null;
         var _loc2_:TextField = null;
         var _loc6_:int = 0;
         var _loc7_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(5);
         _loc7_.sortOn("Id",16);
         var _loc3_:int = int(_loc7_.length);
         _vbox.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc1_ = new ChristmasHirtItem();
            _loc1_.temp = _loc7_[_loc5_];
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc5_++;
         }
         _vbox.commitChanges();
         _hirtPanel.invalidateViewport();
         var _loc4_:Array = TempleteManager.instance.christmasLotteryTempCate.getTemplatesByType(4);
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc6_];
            _loc2_ = _hirtMc.mc_turn.mc_cc["txt_" + _loc6_];
            _loc2_.text = "X" + _loc8_.ItemId;
            _hirtNumList.push(_loc8_.ItemId);
            _loc6_++;
         }
         _chargeTxt.text = LanguageMgr.GetTranslation("ChristmasFrame.hirt.recharge");
         _txtBit.setText("" + model.totalConsume);
      }
      
      public function updateView() : void
      {
         var _loc2_:Dictionary = model.consumptionRewardDic;
         for each(var _loc1_:ChristmasHirtItem in _itemList)
         {
            _loc1_.updateView(_loc2_,model.totalConsume);
         }
         _txtBit.setText("" + model.totalConsume);
      }
      
      public function play(param1:int) : void
      {
         _hirtMc.mc_mask.visible = false;
         model.isHirting = true;
         var _loc2_:int = 600 + Math.random() * 2000;
         _hirtMc.mc_turn.play();
         clearTimeout(_playUid);
         _playUid = setTimeout(playStop,_loc2_,param1);
      }
      
      private function playStop(param1:int) : void
      {
         var _loc2_:int = _hirtNumList.indexOf(param1);
         var _loc3_:Array = [1,9,7,5,3];
         _hirtMc.mc_turn.gotoAndStop(_loc3_[_loc2_]);
         model.isHirting = false;
         _hirtMc.mc_mask.visible = true;
         _hirtMc.mc_mask.gotoAndPlay(1);
         ChristmasManager.instance.opRequest(7,model.hirtTempId,2);
         model.hirtTempId = 0;
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         clearTimeout(_playUid);
         model.isHirting = false;
         model.hirtTempId = 0;
         ObjectUtils.disposeObject(_role);
         _role = null;
         ObjectUtils.disposeViolentMc(_hirtMc);
         _hirtMc = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_hirtPanel);
         _hirtPanel = null;
         ObjectUtils.disposeObject(_hirtTimeTxt);
         _hirtTimeTxt = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_chargeTxt);
         _chargeTxt = null;
         ObjectUtils.disposeObject(_txtBit);
         _txtBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

