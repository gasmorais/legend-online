package firstpay
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyConditionData;
   import funny.datas.FunnyRewardData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class RechargeFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _upBack:Bitmap;
      
      private var _middleBack:Bitmap;
      
      private var _downBack:Bitmap;
      
      private var _roleIcon:Bitmap;
      
      private var _describe:MovieClip;
      
      private var _rewardTxt:Bitmap;
      
      private var _itemContan:HBox;
      
      private var _currIndexTxt:GradientText;
      
      private var _nextIndexTxt:GradientText;
      
      private var _nextContan:HBox;
      
      private var _payBtn:IconButton;
      
      private var _currIndex:int;
      
      private var _numArr:Array;
      
      public function RechargeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("rechargetime.bg");
         _upBack = ComponentFactory.Instance.creatBitmap("asset.rechargetime.upBack");
         _middleBack = ComponentFactory.Instance.creatBitmap("asset.rechargetime.middleBack");
         _downBack = ComponentFactory.Instance.creatBitmap("asset.rechargetime.downBack");
         _itemContan = ComponentFactory.Instance.creatComponentByStylename("rechargetime.ItemBox");
         _nextContan = ComponentFactory.Instance.creatComponentByStylename("rechargetime.nextItemBox");
         _payBtn = ComponentFactory.Instance.creatComponentByStylename("rechargetime.PayBtn");
         _roleIcon = ComponentFactory.Instance.creatBitmap("asset.rechargetime.RoleAsset");
         _describe = ComponentFactory.Instance.creat("asset.rechargetime.describeTxt");
         _rewardTxt = ComponentFactory.Instance.creatBitmap("asset.rechargetime.ValueAsset");
         _currIndexTxt = ComponentFactory.Instance.creatComponentByStylename("rechagetime.Gradient.currIndexTxt");
         _nextIndexTxt = ComponentFactory.Instance.creatComponentByStylename("rechagetime.Gradient.nextIndexTxt");
         _numArr = LanguageMgr.GetTranslation("firstpay.RechargeFrame.num").split("|");
         this.titleText = LanguageMgr.GetTranslation("firstpay.RechargeFrame.titleTxt");
         _describe.x = 212;
         _describe.y = 13;
      }
      
      private function get data() : Vector.<FunnyBagData>
      {
         return FunnyManager.instance.model.rechargeBagDataArr;
      }
      
      private function refreshGoods() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         _currIndex = -1;
         if(data == null)
         {
            dispose();
            return;
         }
         var _loc5_:int = int(ArmyManager.instance.thane.job);
         _loc4_ = 0;
         while(_loc4_ < data.length)
         {
            if((data[_loc4_] as FunnyBagData).status == 3)
            {
               _currIndex = _loc4_;
               break;
            }
            _loc4_++;
         }
         if(_currIndex == -1)
         {
            dispose();
            return;
         }
         var _loc1_:Vector.<FunnyRewardData> = (data[_currIndex] as FunnyBagData).rewardList;
         _loc1_.sort(sortMasterType);
         var _loc6_:Vector.<FunnyConditionData> = (data[_currIndex] as FunnyBagData).conditionList;
         _itemContan.disposeAllChildren();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc1_[_loc3_].temId;
            _loc7_.count = _loc1_[_loc3_].count;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("rechargetime.Item");
            _loc2_.data = _loc7_;
            _itemContan.addChild(_loc2_);
            _loc3_++;
         }
         _currIndexTxt.text = LanguageMgr.GetTranslation("firstpay.RechargeFrame.currIndexTxt.text",_numArr[_currIndex],(_loc6_[0] as FunnyConditionData).value);
         _nextContan.visible = false;
         _middleBack.visible = false;
         _nextIndexTxt.visible = false;
         _downBack.y = 298;
         this.height = 393;
         _bg.height = 305;
      }
      
      private function sortMasterType(param1:Object, param2:Object) : int
      {
         var _loc5_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         if(param1.temType == 1)
         {
            _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.temId);
         }
         else
         {
            _loc5_ = TempleteManager.instance.starTempalteCate.getTemplateByID(param1.temId);
         }
         if(param2.temType == 1)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.temId);
         }
         else
         {
            _loc3_ = TempleteManager.instance.starTempalteCate.getTemplateByID(param2.temId);
         }
         if(_loc5_ && !_loc3_)
         {
            _loc4_ = -1;
         }
         else if(!_loc5_ && _loc3_)
         {
            _loc4_ = 1;
         }
         else if(!_loc5_ && !_loc3_)
         {
            _loc4_ = 0;
         }
         else if(_loc5_.Profile > _loc3_.Profile)
         {
            _loc4_ = -1;
         }
         else if(_loc5_.Profile < _loc3_.Profile)
         {
            _loc4_ = 1;
         }
         else if(_loc5_.MasterType > _loc3_.MasterType)
         {
            _loc4_ = 1;
         }
         else if(_loc5_.MasterType < _loc3_.MasterType)
         {
            _loc4_ = -1;
         }
         _loc5_ = null;
         _loc3_ = null;
         return _loc4_;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addToContent(_bg);
         }
         if(_upBack)
         {
            addToContent(_upBack);
         }
         if(_middleBack)
         {
            addToContent(_middleBack);
         }
         if(_downBack)
         {
            addToContent(_downBack);
         }
         if(_closeButton)
         {
            addToContent(_closeButton);
         }
         if(_roleIcon)
         {
            addToContent(_roleIcon);
         }
         if(_describe)
         {
            addToContent(_describe);
         }
         if(_payBtn)
         {
            addToContent(_payBtn);
         }
         if(_rewardTxt)
         {
            addToContent(_rewardTxt);
         }
         if(_currIndexTxt)
         {
            addToContent(_currIndexTxt);
         }
         if(_nextIndexTxt)
         {
            addToContent(_nextIndexTxt);
         }
         if(_itemContan)
         {
            addToContent(_itemContan);
         }
         if(_nextContan)
         {
            addToContent(_nextContan);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__response);
         _payBtn.addEventListener("click",__payHandler);
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__refreshView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         _payBtn.removeEventListener("click",__payHandler);
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__refreshView);
      }
      
      private function __payHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
         dispose();
      }
      
      private function __refreshView(param1:FunnyEvent) : void
      {
         refreshGoods();
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         refreshGoods();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_upBack);
         _upBack = null;
         ObjectUtils.disposeObject(_middleBack);
         _middleBack = null;
         ObjectUtils.disposeObject(_downBack);
         _downBack = null;
         ObjectUtils.disposeObject(_roleIcon);
         _roleIcon = null;
         ObjectUtils.disposeObject(_nextContan);
         _nextContan = null;
         ObjectUtils.disposeObject(_describe);
         _describe = null;
         ObjectUtils.disposeObject(_rewardTxt);
         _rewardTxt = null;
         ObjectUtils.disposeObject(_itemContan);
         _itemContan = null;
         ObjectUtils.disposeObject(_payBtn);
         _payBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

