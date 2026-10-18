package carnvial.view
{
   import carnvial.utils.CarnivalLockOper;
   import carnvial.utils.MoveSomeController;
   import chat.ChatManager;
   import chat.datas.ChatData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CarnivalLuckDrawTemplateInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.CarnivalManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class CarnivalBaoPage extends BaseCarnivalPage
   {
      
      private var _getBaoBg:MutipleImage;
      
      private var _getBaoStartBtn:IconButton;
      
      private var _mk:Bitmap;
      
      private var _getBaoDes:FilterFrameText;
      
      private var _getBaoGNum:FilterFrameText;
      
      private var _goodId:int;
      
      private var _needOnce:int;
      
      private var _leftCC:MoveSomeController;
      
      private var _leftTempList:Array;
      
      private var _rightCC:MoveSomeController;
      
      private var _rightTempList:Array;
      
      private var _down:Bitmap;
      
      private var _up:Bitmap;
      
      private var _needIcon:BaseIconView;
      
      private var _leftRewardStr:String;
      
      private var _rightRewardStr:String;
      
      private var _rewardCount:int;
      
      private var _tipPools:Array = [];
      
      public function CarnivalBaoPage()
      {
         var _loc3_:Array = null;
         var _loc2_:GoodsInfo = null;
         super();
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("CarnivalLuckyDraw");
         if(_loc1_)
         {
            _loc3_ = _loc1_.ConfigValue.split(",");
            _goodId = int(_loc3_[0]);
            _needOnce = int(_loc3_[1]);
            _needIcon.icon = IconFactory.getGoodsIconByTID(_goodId);
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _goodId;
            _needIcon.tipData = _loc2_;
         }
         initEvent();
         refreshView();
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _getBaoStartBtn.addEventListener("click",clickHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _getBaoStartBtn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         _getBaoStartBtn.enable = false;
         CarnivalLockOper.Ins.doCall(true);
         CarnivalManager.Instance.opRequest(6);
      }
      
      override protected function updateInfoHandler(param1:NotificationEvent) : void
      {
         refreshView(true);
      }
      
      private function refreshView(param1:Boolean = false) : void
      {
         var _loc5_:String = null;
         var _loc7_:Array = null;
         var _loc2_:CarnivalLuckDrawTemplateInfo = null;
         var _loc3_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc6_:String = null;
         updateBtnState();
         if(param1)
         {
            _loc5_ = model.result;
            if(_loc5_ != "" && _loc5_.length > 0)
            {
               _loc7_ = _loc5_.split(",");
               if(_loc7_.length == 2)
               {
                  _rewardCount = 0;
                  model.result = "";
                  _loc3_ = findPrams(_leftTempList,int(_loc7_[0]));
                  _loc8_ = int(_loc3_[0]);
                  _loc2_ = _loc3_[1];
                  _loc9_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.Item);
                  _leftRewardStr = _loc9_.TemplateName + "x" + _loc2_.ItemNum;
                  _loc8_ = chageIdx(_loc8_,_leftTempList.length);
                  _leftCC.start(_loc8_);
                  _loc3_ = findPrams(_rightTempList,int(_loc7_[1]));
                  _loc2_ = _loc3_[1];
                  _loc4_ = int(_loc3_[0]);
                  _loc9_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.Item);
                  _rightRewardStr = _loc9_.TemplateName + "x" + _loc2_.ItemNum;
                  _loc4_ = chageIdx(_loc4_,_rightTempList.length);
                  _rightCC.start(_loc4_);
                  _loc6_ = LanguageMgr.GetTranslation("carnival.recharge.rewardMore",_leftRewardStr,_rightRewardStr);
                  _tipPools.push(_loc6_);
               }
            }
            else
            {
               updateBtnState();
            }
         }
      }
      
      private function findPrams(param1:Array, param2:int) : Array
      {
         var _loc5_:CarnivalLuckDrawTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = int(param1 ? param1.length : 0);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = param1[_loc6_];
            if(_loc5_.Id == param2)
            {
               _loc3_ = [_loc6_,_loc5_];
               break;
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      private function chageIdx(param1:int, param2:int) : int
      {
         var _loc3_:int = 3;
         var _loc4_:int = param1 - _loc3_;
         if(_loc4_ < 0)
         {
            _loc4_ = param1 + param2 - _loc3_;
         }
         return _loc4_;
      }
      
      override protected function initView() : void
      {
         _getBaoBg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.getBaoBg");
         _getBaoStartBtn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.getBaoStartBtn");
         _mk = ComponentFactory.Instance.creatBitmap("asset.carniver.getBao.mk");
         _getBaoDes = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.getBaoDes");
         _getBaoGNum = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.getBaoGNum");
         _getBaoDes.htmlText = LanguageMgr.GetTranslation("carnival.luck.baoTip");
         _down = ComponentFactory.Instance.creatBitmap("asset.carniver.getBao.down");
         _up = ComponentFactory.Instance.creatBitmap("asset.carniver.getBao.up");
         _needIcon = ComponentFactory.Instance.creatCustomObject("ui.carniver.needBaogIcon");
         _leftTempList = TempleteManager.instance.carnivalLuckDrawTemplateCate.getTempList(3,1);
         _leftCC = creatMoveCC(_leftTempList,1,1);
         _rightTempList = TempleteManager.instance.carnivalLuckDrawTemplateCate.getTempList(3,2);
         _rightCC = creatMoveCC(_rightTempList,2,2);
         addChild(_getBaoBg);
         addChild(_getBaoStartBtn);
         addChild(_getBaoDes);
         addChild(_getBaoGNum);
         addChild(_leftCC);
         addChild(_rightCC);
         addChild(_mk);
         addChild(_down);
         addChild(_up);
         addChild(_needIcon);
         _leftCC.initMask(358,61,28,-4);
         _rightCC.initMask(358,61,-335,-4);
      }
      
      private function creatMoveCC(param1:Array, param2:int, param3:int) : MoveSomeController
      {
         var _loc5_:BaseItemView = null;
         var _loc7_:CarnivalLuckDrawTemplateInfo = null;
         var _loc8_:int = 0;
         var _loc10_:Array = [];
         var _loc9_:Array = [];
         var _loc6_:int = int(param1 ? param1.length : 0);
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = param1[_loc8_];
            _loc5_ = creatGoodsItem(_loc7_);
            _loc10_.push(_loc5_);
            _loc5_ = creatGoodsItem(_loc7_);
            _loc9_.push(_loc5_);
            _loc8_++;
         }
         return ComponentFactory.Instance.creatCustomObject("ui.carnival.duoBaoCC.f" + param2,[_loc10_,_loc9_,61,param3,3000,25,10,moveCallBack]);
      }
      
      private function moveCallBack() : void
      {
         _rewardCount = _rewardCount + 1;
         if(_rewardCount >= 2)
         {
            updateBtnState();
            CarnivalLockOper.Ins.doCall(false);
            showRewardInfos();
         }
      }
      
      private function showRewardInfos() : void
      {
         var _loc2_:ChatData = null;
         if(_tipPools == null || _tipPools.length == 0)
         {
            return;
         }
         var _loc1_:String = _tipPools.pop();
         if(_loc1_ != null)
         {
            MessageTipManager.instance().show(_loc1_);
            _loc2_ = new ChatData();
            _loc2_.channel = 3;
            _loc2_.type = 1;
            _loc2_.msg = _loc1_;
            _loc2_.commit();
            ChatManager.instance.model.addChat(_loc2_);
         }
      }
      
      private function updateBtnState() : void
      {
         var _loc1_:int = 0;
         if(_goodId > 0)
         {
            _loc1_ = int(GoodsManager.instance.getGoodsNumByTempId(_goodId));
         }
         _getBaoGNum.text = "" + _loc1_;
         if(_loc1_ >= _needOnce)
         {
            _getBaoStartBtn.enable = true;
         }
         else
         {
            _getBaoStartBtn.enable = false;
         }
      }
      
      private function creatGoodsItem(param1:CarnivalLuckDrawTemplateInfo) : BaseItemView
      {
         var _loc2_:BaseItemView = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = param1.Item;
         _loc3_.count = param1.ItemNum;
         _loc2_.data = _loc3_;
         return _loc2_;
      }
      
      override protected function clearView() : void
      {
         CarnivalLockOper.Ins.doCall(false);
         if(_leftCC)
         {
            _leftCC.dispose();
         }
         _leftCC = null;
         if(_rightCC)
         {
            _rightCC.dispose();
         }
         _rightCC = null;
         ObjectUtils.disposeObject(_getBaoBg);
         _getBaoBg = null;
         ObjectUtils.disposeObject(_getBaoStartBtn);
         _getBaoStartBtn = null;
         ObjectUtils.disposeObject(_mk);
         _mk = null;
         ObjectUtils.disposeObject(_getBaoDes);
         _getBaoDes = null;
         ObjectUtils.disposeObject(_getBaoGNum);
         _getBaoGNum = null;
         ObjectUtils.disposeObject(_down);
         _down = null;
         ObjectUtils.disposeObject(_up);
         _up = null;
         if(_tipPools != null)
         {
            showRewardInfos();
         }
         _tipPools = null;
         _leftTempList = null;
         _rightTempList = null;
      }
   }
}

