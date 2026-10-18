package playerinfo.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import events.AppellEvent;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.AppellSocketOutManager;
   import mvc.module.appell.AppellModel;
   import mvc.module.armyII.UserArmy;
   import utils.GuideUtils;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class PlayerAttributeView extends Component
   {
      
      private var _appellTxt:FilterFrameText;
      
      private var _appellComBox:ComboBox;
      
      private var _gappellTxt:GradientText;
      
      private var _appellTip:StripView;
      
      private var _checkTxt:FilterFrameText;
      
      private var _backImg:ScaleFrameImage;
      
      private var _selected:Boolean = false;
      
      public function PlayerAttributeView()
      {
         super();
         initView();
         initEvent();
         if(GuideUtils.checkGuideStep("appell",1))
         {
            GuideUtils.flash(_checkTxt);
         }
      }
      
      private function initView() : void
      {
         _backImg = ComponentFactory.Instance.creatComponentByStylename("army.attribute.AppellComBoxBtnBack2");
         _appellTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThanehonouerTxt");
         _appellComBox = ComponentFactory.Instance.creatComponentByStylename("army.attribute.AppellComBox");
         _appellTip = ComponentFactory.Instance.creatCustomObject("army.attribute.AppellTip");
         _checkTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneCheckTxt");
         refreshAppellPanel();
         addChild(_appellTip);
         _checkTxt.htmlText = LanguageMgr.GetTranslation("armyII.PlayerAttributeView.CheckTxt");
         _appellTip.addChild(createShape(40));
         _appellTip.tipData = LanguageMgr.GetTranslation("armyII.PlayerAttributeView.Tip03");
         _backImg.setFrame(1);
         _appellComBox.button.addChild(_backImg);
         _appellComBox.textField.visible = false;
         refreshAppellInfo();
      }
      
      private function createShape(param1:int = 175) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16711680,0);
         _loc2_.graphics.drawRect(0,0,param1,20);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
      
      private function initEvent() : void
      {
         _appellComBox.button.addEventListener("mouseOver",__overhandler);
         _appellComBox.button.addEventListener("mouseOut",__outhandler);
         _appellComBox.button.addEventListener("click",__clickHandler);
         _checkTxt.addEventListener("click",__checkTxtClickHandler);
         thane.addEventListener("APPELL_CHANGE",__updatePlayerAppellHandler);
         appellModel.addEventListener("APPELL_DATA_UPDATA",__updateAppellDataHandler);
         _appellComBox.listPanel.addEventListener("removedFromStage",__removedHandler);
         _appellComBox.listPanel.list.addEventListener("listItemClick",__honourChangeHandler);
         NotificationManager.instance.addEventListener("APPELL",__appellSwitchChange);
      }
      
      private function removeEvent() : void
      {
         _appellComBox.button.removeEventListener("mouseOver",__overhandler);
         _appellComBox.button.removeEventListener("mouseOut",__outhandler);
         _appellComBox.button.removeEventListener("click",__clickHandler);
         _checkTxt.removeEventListener("click",__checkTxtClickHandler);
         thane.removeEventListener("APPELL_CHANGE",__updatePlayerAppellHandler);
         appellModel.removeEventListener("APPELL_DATA_UPDATA",__updateAppellDataHandler);
         _appellComBox.listPanel.removeEventListener("removedFromStage",__removedHandler);
         _appellComBox.listPanel.list.removeEventListener("listItemClick",__honourChangeHandler);
         NotificationManager.instance.removeEventListener("APPELL",__appellSwitchChange);
      }
      
      private function __overhandler(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            _backImg.setFrame(2);
         }
      }
      
      private function __outhandler(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            _backImg.setFrame(1);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         _selected = !_selected;
         _backImg.setFrame(3);
      }
      
      private function __removedHandler(param1:Event) : void
      {
         if(_selected)
         {
            _backImg.setFrame(1);
         }
         _selected = false;
      }
      
      private function __appellSwitchChange(param1:NotificationEvent) : void
      {
         refreshAppellPanel();
      }
      
      private function refreshAppellPanel() : void
      {
         if(VersionSwitch.APPELL)
         {
            addChild(_appellComBox);
            addChild(_appellTip);
            addChild(_checkTxt);
            if(_appellTxt.parent)
            {
               _appellTxt.parent.removeChild(_appellTxt);
            }
         }
         else
         {
            if(_appellComBox.parent)
            {
               _appellComBox.parent.removeChild(_appellComBox);
            }
            if(_appellTip.parent)
            {
               _appellTip.parent.removeChild(_appellTip);
            }
            if(_checkTxt.parent)
            {
               _checkTxt.parent.removeChild(_checkTxt);
            }
            addChild(_appellTxt);
         }
      }
      
      private function __honourChangeHandler(param1:ListItemEvent) : void
      {
         var _loc2_:int = int(param1.cellValue.id);
         if(_loc2_ != thane.appellId)
         {
            AppellSocketOutManager.exchangeAppell(_loc2_);
         }
      }
      
      private function __updatePlayerAppellHandler(param1:PlayerEvent) : void
      {
         refreshAppellInfo();
      }
      
      private function __updateAppellDataHandler(param1:AppellEvent) : void
      {
         refreshAppellInfo();
      }
      
      private function __checkTxtClickHandler(param1:MouseEvent) : void
      {
         GuideUtils.stopFlash(_checkTxt);
         if(GuideUtils.checkGuideStep("appell",1))
         {
            GuideUtils.setGuideStep("appell",2);
         }
         FrameControllerManager.instance.openControllerByInfo("appell");
      }
      
      private function honourEnabled() : void
      {
         if(thane.grades >= 1)
         {
            _appellComBox.button.enable = true;
            _checkTxt.mouseEnabled = true;
            _checkTxt.filters = [];
            _appellTip.visible = false;
         }
         else
         {
            _appellComBox.button.enable = false;
            _checkTxt.mouseEnabled = false;
            _checkTxt.filters = [UIFilter.getGrayFilter()];
            _appellTip.visible = true;
         }
      }
      
      private function sortAppell(param1:AppellInfoTemplate, param2:AppellInfoTemplate) : int
      {
         if(param1.Sort < param2.Sort)
         {
            return -1;
         }
         if(param1.Sort > param2.Sort)
         {
            return 1;
         }
         return 0;
      }
      
      private function refreshAppellInfo() : void
      {
         var _loc3_:Object = null;
         var _loc1_:AppellInfoTemplate = null;
         var _loc4_:int = 0;
         honourEnabled();
         var _loc5_:Array = [];
         if(appellModel.appells)
         {
            _loc5_ = appellModel.appells.getList();
         }
         _loc5_.sort(sortAppell);
         _appellComBox.listPanel.vectorListModel.clear();
         var _loc6_:String = "army.HonerText";
         var _loc2_:Object = {
            "id":0,
            "name":LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not"),
            "style":_loc6_
         };
         _appellComBox.listPanel.vectorListModel.append(_loc2_);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc1_ = _loc5_[_loc4_] as AppellInfoTemplate;
            if(!(_loc1_.isGet != true && _loc1_.TemplateId != thane.appellId))
            {
               _loc6_ = "army.HonerText" + _loc1_.Quality;
               _loc3_ = {
                  "id":_loc1_.TemplateId,
                  "name":_loc1_.Title,
                  "style":_loc6_
               };
               _appellComBox.listPanel.vectorListModel.append(_loc3_);
               if(_loc1_.TemplateId == thane.appellId)
               {
                  _loc2_ = _loc3_;
               }
            }
            _loc4_++;
         }
         _appellComBox.listPanel.list.defaultSelectItemByCellValue = _loc2_;
         _appellTxt.text = LanguageMgr.GetTranslation("switchAppell");
         setGradientAppell(_loc2_["style"],_loc2_["name"]);
      }
      
      private function setGradientAppell(param1:String, param2:String) : void
      {
         if(param2 == LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not"))
         {
            param2 = LanguageMgr.GetTranslation("switchAppell");
         }
         if(_gappellTxt && _gappellTxt.parent)
         {
            _gappellTxt.parent.removeChild(_gappellTxt);
         }
         ObjectUtils.disposeObject(_gappellTxt);
         _gappellTxt = null;
         _gappellTxt = ComponentFactory.Instance.creatComponentByStylename(param1);
         _gappellTxt.text = param2;
         _gappellTxt.x = 5;
         _gappellTxt.y = 8;
         _gappellTxt.mouseEnabled = false;
         _gappellTxt.mouseChildren = false;
         addChild(_gappellTxt);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get army() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get thane() : ThaneInfo
      {
         return army.baseHero;
      }
      
      private function get appellModel() : AppellModel
      {
         return FrameControllerManager.instance.appellControler.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_appellTxt);
         _appellTxt = null;
         ObjectUtils.disposeObject(_gappellTxt);
         _gappellTxt = null;
         ObjectUtils.disposeObject(_appellComBox);
         _appellComBox = null;
         ObjectUtils.disposeObject(_checkTxt);
         _checkTxt = null;
         ObjectUtils.disposeObject(_appellTip);
         _appellTip = null;
         ObjectUtils.disposeObject(_backImg);
         _backImg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

