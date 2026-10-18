package star.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import mvc.module.star.StarModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarManager;
   import yishi.utils.IconFactory;
   import yishi.utils.StarHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.ConfirmSellFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class StarIconView extends BaseIconView implements IManualSize
   {
      
      private var _starName:FilterFrameText;
      
      private var _pickupBtn:TextButton;
      
      private var _sellBtn:TextButton;
      
      private var _pickupHitArea:Sprite;
      
      private var _sellHitArea:Sprite;
      
      private var _data:StarInfo;
      
      public function StarIconView(param1:Function = null)
      {
         super(param1);
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _starName = ComponentFactory.Instance.creatComponentByStylename("star.StarIconViewNameTxt");
         _pickupBtn = ComponentFactory.Instance.creatComponentByStylename("star.PickupBtn");
         _sellBtn = ComponentFactory.Instance.creatComponentByStylename("star.SellBtn");
         _pickupBtn.text = LanguageMgr.GetTranslation("star.view.StarIconView.pickup");
         _sellBtn.text = LanguageMgr.GetTranslation("star.view.StarIconView.sell");
         _pickupHitArea = new Sprite();
         _sellHitArea = new Sprite();
         _pickupHitArea.graphics.beginFill(16777215,0);
         _pickupHitArea.graphics.drawRect(15,3,30,16);
         _pickupHitArea.graphics.endFill();
         _sellHitArea.graphics.beginFill(16777215,0);
         _sellHitArea.graphics.drawRect(15,3,30,16);
         _sellHitArea.graphics.endFill();
         _pickupBtn.addChild(_pickupHitArea);
         _pickupBtn.hitArea = _pickupHitArea;
         _sellBtn.addChild(_sellHitArea);
         _sellBtn.hitArea = _sellHitArea;
      }
      
      override protected function addChildren() : void
      {
         if(_iconContainer)
         {
            addChild(_iconContainer);
         }
         if(_loading)
         {
            addChild(_loading);
         }
         if(_starName)
         {
            addChild(_starName);
         }
         if(_pickupBtn)
         {
            addChild(_pickupBtn);
         }
         if(_sellBtn)
         {
            addChild(_sellBtn);
         }
      }
      
      private function addEvent() : void
      {
         _pickupBtn.addEventListener("click",__pickupClick);
         _sellBtn.addEventListener("click",__sellClick);
      }
      
      private function removeEvent() : void
      {
         if(_pickupBtn)
         {
            _pickupBtn.removeEventListener("click",__pickupClick);
         }
         if(_sellBtn)
         {
            _sellBtn.removeEventListener("click",__sellClick);
         }
      }
      
      private function __sellClick(param1:MouseEvent) : void
      {
         var _loc3_:ConfirmSellFrame = null;
         var _loc2_:String = null;
         if(!_data || !_data.template)
         {
            return;
         }
         if(_data.grade > 1 || _data.gp > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("star.view.StarIconView.composedTip"));
            return;
         }
         if(_data.template.Profile >= 5 && _data.template.Profile != 6)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmSellFrame");
            _loc2_ = LanguageMgr.GetTranslation("star.view.StarIconView.confirmSellTip",StarHelper.getStarHtmlName(_data.template)) + "\n" + LanguageMgr.GetTranslation("yishi.view.ConfirmSellFrame.content.htmlText02") + "<font color=\'#01ccff\'>[YES]</font>" + LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.confirmComposeTip2");
            _loc3_.show(_loc2_,_data,sellCall);
            return;
         }
         sellCall(true,true,_data);
      }
      
      private function sellCall(param1:Boolean, param2:Boolean, param3:Object) : void
      {
         if(param1 && param3)
         {
            starModel.delWay = 2;
            starManager.sendStarPick(param3.pos,2);
         }
      }
      
      private function __pickupClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!_data)
         {
            return;
         }
         var _loc3_:int = int(starManager.getStarListByBagType(1).getList().length);
         if(_loc3_ >= 12 + playerInfo.starBagCount)
         {
            _loc2_ = LanguageMgr.GetTranslation("star.view.StarIconView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         starModel.delWay = 1;
         starManager.sendStarPick(_data.pos,1);
      }
      
      public function get data() : StarInfo
      {
         return _data;
      }
      
      public function set data(param1:StarInfo) : void
      {
         _data = param1;
         if(!_data || !_data.template)
         {
            _starName.text = "";
            tipData = null;
            icon = null;
            return;
         }
         icon = IconFactory.getCommonIconPath(_data.template.Icon);
         tipData = {"starData":_data};
         _starName.text = _data.template.TemplateName;
         _starName.setFrame(_data.template.Profile);
         if(_data.template.Profile <= 1)
         {
            if(_pickupBtn.parent)
            {
               _pickupBtn.parent.removeChild(_pickupBtn);
            }
            _sellBtn.x = -29;
         }
      }
      
      public function removeAllButIcon() : void
      {
         if(_starName && _starName.parent)
         {
            _starName.parent.removeChild(_starName);
         }
         if(_pickupBtn && _pickupBtn.parent)
         {
            _pickupBtn.parent.removeChild(_pickupBtn);
         }
         if(_sellBtn && _sellBtn.parent)
         {
            _sellBtn.parent.removeChild(_sellBtn);
         }
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      private function get starModel() : StarModel
      {
         return StarManager.instance.starModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,98,90);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         if(_starName)
         {
            _starName.dispose();
         }
         _starName = null;
         if(_pickupBtn)
         {
            _pickupBtn.dispose();
         }
         _pickupBtn = null;
         if(_sellBtn)
         {
            _sellBtn.dispose();
         }
         _sellBtn = null;
         _pickupHitArea = null;
         _sellHitArea = null;
         super.dispose();
      }
   }
}

