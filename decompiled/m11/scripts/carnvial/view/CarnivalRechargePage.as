package carnvial.view
{
   import carnvial.item.CarnivalRechargeItem;
   import carnvial.utils.CarnivalLockOper;
   import carnvial.utils.LightTurnController;
   import chat.ChatManager;
   import chat.datas.ChatData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.templates.CarnivalLuckDrawTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.CarnivalManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.tips.MessageTipManager;
   
   public class CarnivalRechargePage extends BaseCarnivalPage
   {
      
      private var _outDic:Array = [];
      
      private const OUTPOS_LIST:Array = [[358,86],[441,86],[525,86],[607,86],[689,86],[689,169],[689,252],[689,334],[689,418],[607,418],[525,417],[441,418],[358,418],[358,334],[358,252],[358,169]];
      
      private var _inDic:Array = [];
      
      private const INPOS_LIST:Array = [[431,160],[525,160],[616,160],[616,252],[616,342],[525,343],[431,343],[431,252]];
      
      private const LUCK_TYPE:int = 1;
      
      private var _luckBtn:BaseButton;
      
      private var _luckTimeTxt:FilterFrameText;
      
      private var _luckTxtBg:Bitmap;
      
      private var _timeBg:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _allCountBg:Image;
      
      private var _allCountTxt:FilterFrameText;
      
      private var _allCount:TextAddBitmap;
      
      private var _outLightCc:LightTurnController;
      
      private var _inLightCc:LightTurnController;
      
      private var _currRestId:int;
      
      private var _tipPools:Array = [];
      
      public function CarnivalRechargePage()
      {
         super();
         initEvent();
         refreshView();
      }
      
      override protected function initView() : void
      {
         _bg = new Bitmap();
         _timeBg = new Bitmap();
         _luckBtn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.chargeDoBtn");
         _luckTxtBg = ComponentFactory.Instance.creatBitmap("asset.carniver.getTimeBg");
         _luckTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.chargeTimeTxt");
         _allCountBg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.rechargeCountTxtBg");
         _allCountTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.rechargeCountTxt");
         _allCount = ComponentFactory.Instance.creatCustomObject("ui.carnival.recharge.allCountBit");
         _allCount.initView("ui.carnival.pointNumTx","asset.core.SmallPointImg");
         addChild(_bg);
         addChild(_timeBg);
         addChild(_luckBtn);
         addChild(_luckTxtBg);
         addChild(_luckTimeTxt);
         addChild(_allCountBg);
         addChild(_allCountTxt);
         addChild(_allCount);
         _allCountTxt.text = LanguageMgr.GetTranslation("carnival.allRecharge");
         _timeBg.x = 14;
         _timeBg.y = 81;
         toLoadImg(_bg,"tab2_bg",_activeId);
         toLoadImg(_timeBg,"tab2_ad",_activeId);
         addOutItems();
         addInItems();
      }
      
      private function addOutItems() : void
      {
         var _loc2_:CarnivalLuckDrawTemplateInfo = null;
         var _loc3_:CarnivalRechargeItem = null;
         var _loc1_:Array = TempleteManager.instance.carnivalLuckDrawTemplateCate.getTempList(1,1);
         _loc1_ = _loc1_.concat();
         _loc1_.unshift(null);
         _loc1_.splice(8,0,null);
         var _loc4_:int = int(_loc1_.length);
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 16)
         {
            _loc2_ = _loc1_[_loc5_];
            _loc3_ = new CarnivalRechargeItem(_loc2_ ? 1 : 0);
            _loc3_.idx = _loc5_;
            _loc3_.tempInfo = _loc2_;
            _loc3_.x = OUTPOS_LIST[_loc5_][0];
            _loc3_.y = OUTPOS_LIST[_loc5_][1];
            addChild(_loc3_);
            _outDic[_loc5_] = _loc3_;
            _loc5_++;
         }
         _outLightCc = new LightTurnController(_outDic,5,2000,35,outCallBack,6);
         _outLightCc.initIdx(1);
      }
      
      private function addInItems() : void
      {
         var _loc1_:CarnivalLuckDrawTemplateInfo = null;
         var _loc2_:CarnivalRechargeItem = null;
         var _loc5_:Array = TempleteManager.instance.carnivalLuckDrawTemplateCate.getTempList(1,2);
         var _loc3_:int = int(_loc5_.length);
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _loc5_[_loc4_];
            _loc2_ = new CarnivalRechargeItem(_loc1_ ? 1 : 0);
            _loc2_.idx = _loc4_;
            _loc2_.tempInfo = _loc1_;
            _loc2_.x = INPOS_LIST[_loc4_][0];
            _loc2_.y = INPOS_LIST[_loc4_][1];
            addChild(_loc2_);
            _inDic[_loc4_] = _loc2_;
            _loc4_++;
         }
         _inLightCc = new LightTurnController(_inDic,5,1500,35,inCallBack,6);
      }
      
      private function outCallBack(param1:Boolean, param2:int) : void
      {
         if(_isDie)
         {
            return;
         }
         if(param1)
         {
            _outLightCc.clearLight(true);
            _inLightCc.start(param2);
         }
         else
         {
            CarnivalLockOper.Ins.doCall(false);
            resetBtnState();
         }
      }
      
      private function inCallBack() : void
      {
         if(_isDie)
         {
            return;
         }
         CarnivalLockOper.Ins.doCall(false);
         resetBtnState();
      }
      
      private function resetBtnState() : void
      {
         _luckBtn.enable = model.lotteryCount > 0;
         showRewardTipInfo();
      }
      
      private function showRewardTipInfo() : void
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:String = null;
         var _loc3_:ChatData = null;
         if(_tipPools == null || _tipPools.length == 0)
         {
            return;
         }
         var _loc1_:CarnivalLuckDrawTemplateInfo = _tipPools.pop();
         if(_loc1_)
         {
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_.Item);
            if(_loc4_)
            {
               _loc2_ = LanguageMgr.GetTranslation("carnival.recharge.get",_loc4_.TemplateName,_loc1_.ItemNum);
               MessageTipManager.instance().show(_loc2_);
               _loc3_ = new ChatData();
               _loc3_.channel = 3;
               _loc3_.type = 1;
               _loc3_.msg = _loc2_;
               _loc3_.commit();
               ChatManager.instance.model.addChat(_loc3_);
            }
         }
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _luckBtn.addEventListener("click",clickHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _luckBtn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:Event) : void
      {
         _luckBtn.enable = false;
         CarnivalLockOper.Ins.doCall(true);
         CarnivalManager.Instance.opRequest(3);
      }
      
      override protected function updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc3_:CarnivalLuckDrawTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc8_:Boolean = false;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         refreshView();
         var _loc2_:int = int(model.result);
         if(_loc2_ > 0)
         {
            _currRestId = _loc2_;
            _loc3_ = TempleteManager.instance.carnivalLuckDrawTemplateCate.getTempInfo(_currRestId);
            _tipPools.push(_loc3_);
            _loc8_ = true;
            for each(_loc4_ in _outDic)
            {
               if(_loc4_.tempInfo && _loc4_.tempInfo.Id == _loc2_)
               {
                  _loc5_ = _loc4_.idx;
                  _loc8_ = false;
                  break;
               }
            }
            _inLightCc.clearLight();
            if(_loc8_)
            {
               for each(_loc4_ in _inDic)
               {
                  if(_loc4_.tempInfo && _loc4_.tempInfo.Id == _loc2_)
                  {
                     _loc6_ = _loc4_.idx;
                     break;
                  }
               }
               _loc7_ = Math.random() * 2;
               _loc5_ = _loc7_ == 1 ? 8 : 0;
               _outLightCc.start(_loc5_,[true,_loc6_]);
            }
            else
            {
               _outLightCc.start(_loc5_,[false,_loc6_]);
            }
         }
      }
      
      private function refreshView() : void
      {
         _allCount.setText("" + model.totalCharge);
         _luckBtn.enable = model.lotteryCount > 0;
         _luckTimeTxt.text = LanguageMgr.GetTranslation("carnival.recharge.time",model.lotteryCount);
      }
      
      override protected function clearView() : void
      {
         var _loc1_:* = null;
         CarnivalLockOper.Ins.doCall(false);
         if(_inLightCc)
         {
            _inLightCc.dispose();
         }
         _inLightCc = null;
         if(_outLightCc)
         {
            _outLightCc.dispose();
         }
         _outLightCc = null;
         for each(_loc1_ in _outDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _outDic = null;
         for each(_loc1_ in _inDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _inDic = null;
         if(_tipPools && _tipPools.length > 0)
         {
            showRewardTipInfo();
         }
         _tipPools = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_timeBg);
         _timeBg = null;
         ObjectUtils.disposeObject(_luckBtn);
         _luckBtn = null;
         ObjectUtils.disposeObject(_luckTimeTxt);
         _luckTimeTxt = null;
         ObjectUtils.disposeObject(_luckTxtBg);
         _luckTxtBg = null;
         ObjectUtils.disposeObject(_allCountBg);
         _allCountBg = null;
         ObjectUtils.disposeObject(_allCountTxt);
         _allCountTxt = null;
         ObjectUtils.disposeObject(_allCount);
         _allCount = null;
      }
   }
}

