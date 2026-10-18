package kingback.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.KingbackManager;
   import mvc.module.kingback.KingbackInfo;
   import mvc.module.kingback.KingbackModel;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class KingbackDayItem extends Sprite implements IManualSize
   {
      
      private static var _daySelectFlg:Bitmap;
      
      private var _content:Sprite;
      
      private var _dayBack:Bitmap;
      
      private var _xday:Bitmap;
      
      private var _kbDayTxt:FilterFrameText;
      
      private var _dbGetFlg:Bitmap;
      
      private var _dayGetBtn:IconButton;
      
      private var _dayGotoTxt:FilterFrameText;
      
      private var _dayInfos:Array;
      
      private var _currInfo:KingbackInfo;
      
      private var _topic:int;
      
      private var _goodsBack:Bitmap;
      
      private var _goodsImg:ScaleFrameImage;
      
      private var _currDayFlg:Bitmap;
      
      private var _idx:int;
      
      private var _gray:Array;
      
      public function KingbackDayItem(param1:int, param2:int)
      {
         super();
         _topic = param1;
         _idx = param2;
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,120,150);
      }
      
      private function initView() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         _content = new Sprite();
         _dayBack = ComponentFactory.Instance.creatBitmap("asset.kingback.dayBack");
         _xday = ComponentFactory.Instance.creatBitmap("asset.kingback.xday");
         _goodsBack = ComponentFactory.Instance.creatBitmap("asset.kingback.goodsBack");
         _goodsImg = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.dayGoodImgs");
         _kbDayTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.kbDayTxt");
         _dbGetFlg = ComponentFactory.Instance.creatBitmap("asset.kingback.dbGetFlg");
         _dayGetBtn = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.dayGetBtn");
         _dayGotoTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.dayGotoTxt");
         if(_daySelectFlg == null)
         {
            _daySelectFlg = ComponentFactory.Instance.creatBitmap("asset.kingback.daySelectFlg");
         }
         addChild(_content);
         _content.addChild(_dayBack);
         _content.addChild(_xday);
         _content.addChild(_goodsBack);
         _content.addChild(_goodsImg);
         _content.addChild(_kbDayTxt);
         _content.addChild(_dbGetFlg);
         _content.addChild(_dayGetBtn);
         _content.addChild(_dayGotoTxt);
         _dayGotoTxt.mouseEnabled = true;
         _dayGotoTxt.htmlText = LanguageMgr.GetTranslation("kingback.gotoCharge.tip");
         buttonMode = true;
         _goodsImg.setFrame(_idx + 1);
      }
      
      private function initEvent() : void
      {
         _dayGotoTxt.addEventListener("link",linkHandler);
         _dayGetBtn.addEventListener("click",clickGetHandler);
         this.addEventListener("click",thisClickHandler);
      }
      
      private function removeEvent() : void
      {
         _dayGotoTxt.removeEventListener("link",linkHandler);
         _dayGetBtn.removeEventListener("click",clickGetHandler);
         this.removeEventListener("click",thisClickHandler);
      }
      
      private function linkHandler(param1:TextEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function clickGetHandler(param1:MouseEvent) : void
      {
         KingbackManager.instance.sendOp(_currInfo.templateId,1);
      }
      
      private function thisClickHandler(param1:MouseEvent) : void
      {
         selected = true;
         NotificationManager.instance.sendNotification("kingback.chooseDay",_currInfo);
      }
      
      private function get model() : KingbackModel
      {
         return KingbackManager.instance.model;
      }
      
      public function set currDayIdx(param1:int) : void
      {
         if(param1 >= _topic)
         {
            _content.filters = null;
            if(param1 == _topic)
            {
               if(_currDayFlg == null)
               {
                  _currDayFlg = ComponentFactory.Instance.creatBitmap("asset.kingback.nowFlg");
                  _content.addChild(_currDayFlg);
               }
            }
            else
            {
               ObjectUtils.disposeObject(_currDayFlg);
               _currDayFlg = null;
            }
         }
         else
         {
            _content.filters = _gray;
            ObjectUtils.disposeObject(_currDayFlg);
            _currDayFlg = null;
         }
      }
      
      public function set dayInfos(param1:Array) : void
      {
         _dayInfos = param1;
         var _loc3_:KingbackInfo = _dayInfos[0];
         var _loc2_:KingbackInfo = _dayInfos[1];
         _currInfo = _loc3_;
         _kbDayTxt.text = "" + _loc3_.tempInfo.Topic;
         if(_loc3_.rewardState == 2)
         {
            _currInfo = _loc2_;
            if(_loc2_.rewardState == 2)
            {
               setBtnState(2);
            }
            else if(_loc2_.rewardState == 1)
            {
               setBtnState(3);
            }
            else if(_loc2_.rewardState == 0)
            {
               setBtnState(4);
            }
         }
         else if(_loc3_.rewardState == 1)
         {
            setBtnState(1);
         }
         else if(_loc3_.rewardState == 0)
         {
            setBtnState(0);
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(param1)
         {
            addChild(_daySelectFlg);
         }
      }
      
      private function setBtnState(param1:int) : void
      {
         _dayGotoTxt.visible = false;
         switch(param1)
         {
            case 0:
               _dbGetFlg.visible = false;
               _dayGetBtn.visible = true;
               _dayGetBtn.enable = false;
               DisplayUtils.setFrame(_dayGetBtn.icon,1);
               break;
            case 1:
               _dbGetFlg.visible = false;
               _dayGetBtn.visible = true;
               _dayGetBtn.enable = true;
               DisplayUtils.setFrame(_dayGetBtn.icon,2);
               break;
            case 2:
               _dbGetFlg.visible = true;
               _dayGetBtn.visible = false;
               break;
            case 3:
               _dbGetFlg.visible = false;
               _dayGetBtn.visible = true;
               _dayGetBtn.enable = true;
               DisplayUtils.setFrame(_dayGetBtn.icon,3);
               break;
            case 4:
               _dbGetFlg.visible = false;
               _dayGetBtn.visible = false;
               _dayGotoTxt.visible = true;
         }
      }
      
      public function refreshState() : void
      {
         this.dayInfos = _dayInfos;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_dayBack);
         _dayBack = null;
         ObjectUtils.disposeObject(_xday);
         _xday = null;
         ObjectUtils.disposeObject(_goodsBack);
         _goodsBack = null;
         ObjectUtils.disposeObject(_daySelectFlg);
         _daySelectFlg = null;
         ObjectUtils.disposeObject(_kbDayTxt);
         _kbDayTxt = null;
         ObjectUtils.disposeObject(_dbGetFlg);
         _dbGetFlg = null;
         ObjectUtils.disposeObject(_dayGetBtn);
         _dayGetBtn = null;
         ObjectUtils.disposeObject(_dayGotoTxt);
         _dayGotoTxt = null;
         ObjectUtils.disposeObject(_goodsImg);
         _goodsImg = null;
         ObjectUtils.disposeObject(_currDayFlg);
         _currDayFlg = null;
         ObjectUtils.disposeAllChildren(_content);
         _content = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _dayInfos = null;
         _currInfo = null;
         _gray = null;
      }
   }
}

