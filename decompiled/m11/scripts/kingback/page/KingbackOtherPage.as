package kingback.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import kingback.item.KingbackOtherItem;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.KingbackManager;
   import mvc.module.kingback.KingbackInfo;
   import mvc.module.kingback.KingbackModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class KingbackOtherPage extends Sprite
   {
      
      public var _otherSpane:ScrollPanel;
      
      public var _otherRWbg:Bitmap;
      
      public var _otherTitles:ScaleFrameImage;
      
      public var _rule:Bitmap;
      
      public var _time:Bitmap;
      
      public var _otherDesTxt:FilterFrameText;
      
      public var _otherTimeTxt:FilterFrameText;
      
      public var _otherNumTxt:FilterFrameText;
      
      public var _otherGoBtn:IconButton;
      
      public var _otherRechargeBtn:IconButton;
      
      public var _otherVbox:VBox;
      
      private var _type:int;
      
      public function KingbackOtherPage(param1:int)
      {
         super();
         _type = param1;
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         _otherSpane = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherSpane");
         _otherRWbg = ComponentFactory.Instance.creatBitmap("asset.kingback.otherRWbg");
         _otherTitles = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherTitles");
         _rule = ComponentFactory.Instance.creatBitmap("asset.kingback.rule");
         _time = ComponentFactory.Instance.creatBitmap("asset.kingback.time");
         _otherDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherDesTxt");
         _otherTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherTimeTxt");
         _otherNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherNumTxt");
         _otherGoBtn = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherGoBtn");
         _otherRechargeBtn = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherRechargeBtn");
         _otherVbox = ComponentFactory.Instance.creatCustomObject("ui.kingback.otherVbox");
         addChild(_otherRWbg);
         addChild(_otherSpane);
         addChild(_otherTitles);
         addChild(_rule);
         addChild(_time);
         addChild(_otherDesTxt);
         addChild(_otherTimeTxt);
         addChild(_otherNumTxt);
         addChild(_otherGoBtn);
         addChild(_otherRechargeBtn);
         _otherSpane.setView(_otherVbox);
         if(_type == 2)
         {
            _otherTitles.setFrame(1);
            DisplayUtils.setFrame(_otherGoBtn.icon,1);
            _otherGoBtn.iconInnerRectString = "10,14,19";
            _otherRechargeBtn.visible = true;
         }
         else
         {
            _otherTitles.setFrame(_type - 2);
            DisplayUtils.setFrame(_otherGoBtn.icon,_type - 2);
            if(_type - 2 == 2)
            {
               _otherGoBtn.iconInnerRectString = "20,9,19";
            }
            else if(_type - 2 == 3)
            {
               _otherGoBtn.iconInnerRectString = "12,13,19";
            }
            else if(_type - 2 == 4)
            {
               _otherGoBtn.iconInnerRectString = "29,13,19";
            }
            else if(_type - 2 == 5)
            {
               _otherGoBtn.iconInnerRectString = "15,13,19";
            }
            else if(_type - 2 == 6)
            {
               _otherGoBtn.iconInnerRectString = "20,13,19";
            }
            _otherRechargeBtn.visible = false;
         }
      }
      
      private function initData() : void
      {
         var _loc1_:KingbackOtherItem = null;
         var _loc10_:KingbackInfo = null;
         var _loc4_:int = 0;
         var _loc7_:ConfigInfosTempInfo = null;
         var _loc11_:Array = null;
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:Array = model.getInfoListByType(_type);
         var _loc2_:int = int(_loc6_ ? _loc6_.length : 0);
         _otherVbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc10_ = _loc6_[_loc4_];
            _loc1_ = new KingbackOtherItem();
            _loc1_.data = _loc10_;
            _otherVbox.addChild(_loc1_);
            if(_loc4_ == 0)
            {
               if(_type == 2)
               {
                  _loc7_ = TempleteManager.instance.getConfigInfoByConfigName("older_reflux_conf");
                  _loc5_ = 1;
                  _loc8_ = 1;
                  _loc9_ = 1;
                  _loc3_ = 1;
                  if(_loc7_)
                  {
                     _loc11_ = _loc7_.ConfigValue.split(",");
                     _loc5_ = int(_loc11_[3]) / 100;
                     _loc8_ = int(_loc11_[4]) / 100;
                  }
                  if(_loc5_ < 1)
                  {
                     _loc9_ = int(1 / _loc5_);
                     _loc5_ = 1;
                  }
                  if(_loc8_ < 1)
                  {
                     _loc3_ = int(1 / _loc8_);
                     _loc8_ = 1;
                  }
                  _otherDesTxt.htmlText = LanguageMgr.GetTranslation("kingback.active.des" + _type,_loc5_,_loc9_,_loc8_,_loc3_);
               }
               else
               {
                  _otherDesTxt.htmlText = LanguageMgr.GetTranslation("kingback.active.des" + _type,_loc10_.tempInfo.getItemNames(true));
               }
               showTargetNum(_loc10_);
            }
            _loc4_++;
         }
         _otherVbox.commitChanges();
         _otherSpane.invalidateViewport();
         setRemainTime();
      }
      
      public function refreshView() : void
      {
         var _loc1_:KingbackOtherItem = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(_otherVbox.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _otherVbox.getChildAt(_loc3_) as KingbackOtherItem;
            _loc1_.refreshState();
            if(_loc3_ == 0)
            {
               showTargetNum(_loc1_.data);
            }
            _loc3_++;
         }
      }
      
      private function showTargetNum(param1:KingbackInfo) : void
      {
         if(_type == 2)
         {
            _otherNumTxt.htmlText = LanguageMgr.GetTranslation("kingback.active.topic",param1.needCounts);
         }
         else
         {
            _otherNumTxt.htmlText = LanguageMgr.GetTranslation("kingback.active.topic2",param1.tempInfo.getItemNames(),param1.needCounts);
         }
      }
      
      public function setRemainTime() : void
      {
         var _loc1_:Number = model.endTime / 1000 - playerModel.sysCurTimeBySecond;
         _otherTimeTxt.text = DateFormatter.getFullTimeString(_loc1_);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : KingbackModel
      {
         return KingbackManager.instance.model;
      }
      
      private function initEvent() : void
      {
         _otherGoBtn.addEventListener("click",goClickHandler);
         _otherRechargeBtn.addEventListener("click",chargeClickHandler);
      }
      
      private function removeEvent() : void
      {
         _otherGoBtn.removeEventListener("click",goClickHandler);
         _otherRechargeBtn.removeEventListener("click",chargeClickHandler);
      }
      
      private function goClickHandler(param1:MouseEvent) : void
      {
         switch(_type - 2)
         {
            case 0:
               FrameControllerManager.instance.openControllerByInfo("newactiveleed");
               break;
            case 2:
               FrameControllerManager.instance.openControllerByInfo("pethallows",1);
               break;
            case 3:
               FrameControllerManager.instance.openControllerByInfo("ancientartifact");
               break;
            case 4:
               FrameControllerManager.instance.openControllerByInfo("goddess");
               break;
            case 5:
               FrameControllerManager.instance.openControllerByInfo("pet");
               break;
            case 6:
               ChildManager.instance.openChildFram();
         }
      }
      
      private function chargeClickHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_otherSpane);
         _otherSpane = null;
         ObjectUtils.disposeObject(_otherRWbg);
         _otherRWbg = null;
         ObjectUtils.disposeObject(_otherTitles);
         _otherTitles = null;
         ObjectUtils.disposeObject(_rule);
         _rule = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_otherDesTxt);
         _otherDesTxt = null;
         ObjectUtils.disposeObject(_otherTimeTxt);
         _otherTimeTxt = null;
         ObjectUtils.disposeObject(_otherNumTxt);
         _otherNumTxt = null;
         ObjectUtils.disposeObject(_otherGoBtn);
         _otherGoBtn = null;
         ObjectUtils.disposeObject(_otherRechargeBtn);
         _otherRechargeBtn = null;
         ObjectUtils.disposeObject(_otherVbox);
         _otherVbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

