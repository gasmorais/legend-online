package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   import utils.LogicUtils;
   import yishi.datas.VersionSwitch;
   import yishi.datas.templates.ChildAssistUpgradeTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNsAttValueView extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _data:ChildData;
      
      private var _vBox3:VBox;
      
      private var _vBox4:VBox;
      
      private var _vBox5:VBox;
      
      private var _vBox6:VBox;
      
      private var _attNameList:Array;
      
      private var _txtList:Vector.<FilterFrameText>;
      
      private var _delay:uint;
      
      private var _withAttri:CustomBitmap;
      
      private var _withAttriLine:CustomBitmap;
      
      private var _contentBg:Image;
      
      private var _slavedBg:Image;
      
      private var _callBtn:IconButton;
      
      private var _upgradeBtn:IconButton;
      
      private var _propertyTxt:FilterFrameText;
      
      private var _childAssistUpgradeTempInfo:ChildAssistUpgradeTempInfo;
      
      public function ChildNsAttValueView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _attNameList = ["Emblem1","Emblem2","Emblem3","Emblem4","Emblem5","Emblem6","Emblem7","Emblem8","Emblem9","Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live","StunAttr"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.bg2");
         _vBox3 = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.vBox3");
         _vBox4 = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.vBox4");
         _vBox5 = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.vBox5");
         _vBox6 = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.vBox6");
         _withAttri = ComponentFactory.Instance.creatCustomObject("ChildAttributeViewII.withAttriImg");
         _withAttriLine = ComponentFactory.Instance.creatCustomObject("ChildAttributeViewII.withAttriLineImg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.contentBg");
         _slavedBg = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.slavedBg");
         _callBtn = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.callBtn");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.upgradeBtn");
         _propertyTxt = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.propertyTxt");
         _txtList = new Vector.<FilterFrameText>();
         addChild(_bg);
         addChild(_vBox3);
         addChild(_vBox4);
         addChild(_vBox5);
         addChild(_vBox6);
         addChild(_withAttri);
         addChild(_withAttriLine);
         if(VersionSwitch.CHILD_ASSIST && Boolean(PlayerManager.instance.currentPlayerModel.playerInfo.isAvenger))
         {
            addChild(_contentBg);
            addChild(_slavedBg);
            addChild(_callBtn);
            addChild(_upgradeBtn);
            addChild(_propertyTxt);
            _bg.height = 422;
         }
         else
         {
            _bg.height = 347;
         }
         addImageAndTxt();
      }
      
      private function addImageAndTxt() : void
      {
         var _loc2_:Bitmap = null;
         var _loc1_:FilterFrameText = null;
         var _loc3_:FilterFrameText = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _attNameList.length)
         {
            if(_loc4_ < 9)
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.nameTxt");
               _loc3_.text = LanguageMgr.GetTranslation("playerinfo.view.ThaneAttributeFrame.txt" + _loc4_);
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.child.ChildAttributeViewII.imageTxt" + (_loc4_ - 5));
            }
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
            _loc1_.setFrame(1);
            if(_loc4_ < 9)
            {
               _vBox5.addChild(_loc3_);
               _vBox6.addChild(_loc1_);
            }
            else
            {
               _vBox3.addChild(_loc2_);
               _vBox4.addChild(_loc1_);
            }
            _txtList.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _attNameList.length)
         {
            if(_loc1_ < 9)
            {
               _txtList[_loc1_].text = data.childAttInfo.resiArr[_loc1_];
            }
            else
            {
               _txtList[_loc1_].text = data.childAttInfo.attValueArr[_loc1_ - 9];
            }
            _loc1_++;
         }
         if(_data.childAssistAwakeLevel > 0)
         {
            _upgradeBtn.visible = true;
            _callBtn.visible = false;
            _childAssistUpgradeTempInfo = TempleteManager.instance.childAssistUpgradeTemplateCate.getTemplateByAwakeLevel(_data.childAssistAwakeLevel);
            if(_childAssistUpgradeTempInfo)
            {
               _propertyTxt.text = _childAssistUpgradeTempInfo.Percentage + "%";
            }
         }
         else
         {
            _upgradeBtn.visible = false;
            _callBtn.visible = true;
            _propertyTxt.text = "0%";
         }
      }
      
      private function initEvent() : void
      {
         if(_callBtn)
         {
            _callBtn.addEventListener("click",__callBtnHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.addEventListener("click",__upgradeBtnHandler);
         }
      }
      
      private function __callBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit","CALL",data);
      }
      
      private function __upgradeBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:ChildAssistUpgradeTempInfo = TempleteManager.instance.childAssistUpgradeTemplateCate.getTemplateByAwakeLevel(_data.childAssistAwakeLevel + 1);
         if(_loc2_)
         {
            FrameControllerManager.instance.openControllerByInfo("childnursingspirit","CALL",data);
            return;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNsAttValueView.awakeUpgrade.isFull"));
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function cleanList() : void
      {
         if(_txtList)
         {
            while(_txtList.length > 0)
            {
               ObjectUtils.disposeObject(_txtList.pop());
            }
            _txtList = null;
         }
      }
      
      override public function dispose() : void
      {
         cleanList();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vBox3);
         _vBox3 = null;
         ObjectUtils.disposeObject(_vBox4);
         _vBox4 = null;
         ObjectUtils.disposeObject(_vBox5);
         _vBox5 = null;
         ObjectUtils.disposeObject(_vBox6);
         _vBox6 = null;
         ObjectUtils.disposeObject(_withAttri);
         _withAttri = null;
         ObjectUtils.disposeObject(_withAttriLine);
         _withAttriLine = null;
         ObjectUtils.disposeObject(_contentBg);
         _contentBg = null;
         ObjectUtils.disposeObject(_slavedBg);
         _slavedBg = null;
         ObjectUtils.disposeObject(_callBtn);
         _callBtn = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_propertyTxt);
         _propertyTxt = null;
         LogicUtils.disposeDisplayCollection(_txtList);
         _txtList = null;
         _data = null;
         _attNameList = null;
         super.dispose();
      }
   }
}

