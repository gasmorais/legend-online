package christmas.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.christmas.ConsumptionRewardInfoMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.manager.ChristmasManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChristmasHirtItem extends Sprite
   {
      
      protected var _bar:Bitmap;
      
      protected var _hirtItemDesTxt:FilterFrameText;
      
      protected var _hirtitemHbox:HBox;
      
      protected var _hirtBtn:IconButton;
      
      protected var _hirtGetBtn:IconButton;
      
      protected var _pointbg:Bitmap;
      
      private var _pointBit:TextAddBitmap;
      
      private var _getFlg:Bitmap;
      
      private var _temp:ChristmasActivitiesTempInfo;
      
      private var _itemList:Array = [];
      
      private var _hirtTxt:FilterFrameText;
      
      public function ChristmasHirtItem()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bar = ComponentFactory.Instance.creatBitmap("asset.Christmas.hirt.bar");
         _hirtItemDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.hirtItemDesTxt");
         _hirtitemHbox = ComponentFactory.Instance.creatCustomObject("ui.christmas.hirtitemHbox");
         _hirtBtn = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.hirtBtn");
         _hirtGetBtn = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.hirtGetBtn");
         _pointbg = ComponentFactory.Instance.creatBitmap("asset.Christmas.hirt.pointbg");
         _pointBit = ComponentFactory.Instance.creatCustomObject("christmasGiftItem.hirtPtBit");
         _pointBit.initView("christmasGiftItem.pointNumTx","asset.core.SmallPointImg");
         _getFlg = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerPreviewItem.bmp");
         _hirtTxt = ComponentFactory.Instance.creatComponentByStylename("ChristmasHirtItem.hirtTxt");
         addChild(_bar);
         addChild(_hirtItemDesTxt);
         addChild(_hirtitemHbox);
         addChild(_hirtBtn);
         addChild(_hirtGetBtn);
         addChild(_pointbg);
         addChild(_pointBit);
         addChild(_hirtTxt);
         addChild(_getFlg);
         _getFlg.visible = false;
         _hirtGetBtn.enable = false;
         _hirtBtn.enable = false;
         _getFlg.x = 335;
         _getFlg.y = 45;
      }
      
      public function updateView(param1:Dictionary, param2:int) : void
      {
         var _loc3_:ConsumptionRewardInfoMsg = param1[_temp.Id];
         if(_loc3_.isGetReward == 1)
         {
            _hirtGetBtn.visible = false;
            _hirtBtn.visible = false;
            _pointbg.visible = false;
            _pointBit.visible = false;
            _hirtTxt.visible = false;
            _getFlg.visible = true;
         }
         else if(_loc3_.multiple > 0)
         {
            _hirtTxt.text = LanguageMgr.GetTranslation("ChristmasHirtItem.hirtTxt.text",_loc3_.multiple);
            _hirtGetBtn.x = 274;
            _hirtBtn.visible = false;
            _pointbg.visible = false;
            _pointBit.visible = false;
         }
         else
         {
            _hirtTxt.text = "";
         }
         if(param2 >= _temp.Para1 && model.hirtTempId == 0)
         {
            _hirtGetBtn.enable = true;
            _hirtBtn.enable = true;
         }
      }
      
      private function initEvent() : void
      {
         _hirtGetBtn.addEventListener("click",getbtnHandler);
         _hirtBtn.addEventListener("click",hirtbtnHandler);
      }
      
      private function removeEvent() : void
      {
         _hirtGetBtn.removeEventListener("click",getbtnHandler);
         _hirtBtn.removeEventListener("click",hirtbtnHandler);
      }
      
      private function getbtnHandler(param1:MouseEvent) : void
      {
         _hirtGetBtn.enable = false;
         ChristmasManager.instance.opRequest(7,_temp.Id,0);
      }
      
      private function hirtbtnHandler(param1:MouseEvent) : void
      {
         if(model.isHirting)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("christmasHirtItem.isHirting.txt"));
            return;
         }
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(_temp.Para2 > _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         _hirtGetBtn.enable = false;
         _hirtBtn.enable = false;
         model.hirtTempId = _temp.Id;
         ChristmasManager.instance.opRequest(7,_temp.Id,1);
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bar);
         _bar = null;
         ObjectUtils.disposeObject(_hirtItemDesTxt);
         _hirtItemDesTxt = null;
         ObjectUtils.disposeObject(_hirtitemHbox);
         _hirtitemHbox = null;
         ObjectUtils.disposeObject(_hirtBtn);
         _hirtBtn = null;
         ObjectUtils.disposeObject(_hirtGetBtn);
         _hirtGetBtn = null;
         ObjectUtils.disposeObject(_pointbg);
         _pointbg = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_pointBit);
         _pointBit = null;
         ObjectUtils.disposeObject(_getFlg);
         _getFlg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
      }
      
      public function set temp(param1:ChristmasActivitiesTempInfo) : void
      {
         _temp = param1;
         if(_temp)
         {
            _hirtItemDesTxt.text = LanguageMgr.GetTranslation("ChristmasHirtItem.hirtItemDestTxt.text",_temp.Para1);
            _pointBit.setText("" + _temp.Para2);
            _hirtitemHbox.beginChanges();
            addReward(_temp.Reward1,_temp.Num1);
            addReward(_temp.Reward2,_temp.Num2);
            addReward(_temp.Reward3,_temp.Num3);
            addReward(_temp.Reward4,_temp.Num4);
            _hirtitemHbox.commitChanges();
         }
      }
      
      private function addReward(param1:int, param2:int) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         if(param1 != 0)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = param1;
            _loc4_.count = param2;
            _loc3_.data = _loc4_;
            _hirtitemHbox.addChild(_loc3_);
            _itemList.push(_loc3_);
         }
      }
   }
}

