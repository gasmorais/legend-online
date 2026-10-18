package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelaAttInfo;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import stelesys.item.StelaSkillItem;
   import stelesys.item.StelesysFuzhuBox;
   import stelesys.item.StelesysHexinItem;
   import stelesys.item.StelesysNameAndValueTxt;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class SteleSysmainView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _leftVbox1:VBox;
      
      private var _leftItemList:Array = [];
      
      private var _middleVbox1:VBox;
      
      private var _middleItemList:Array = [];
      
      private var _simpleList:SimpleTileList;
      
      private var _itemList:Vector.<StelesysFuzhuBox>;
      
      private var _mainBox:StelesysHexinItem;
      
      private var _nameTxt:FilterFrameText;
      
      private var _skillItem:StelaSkillItem;
      
      private var _lineBox:VBox;
      
      public function SteleSysmainView()
      {
         super();
         initView();
         initEvent();
         upDataHandler();
      }
      
      private function initView() : void
      {
         var _loc1_:StelesysNameAndValueTxt = null;
         var _loc2_:StelesysNameAndValueTxt = null;
         var _loc4_:Bitmap = null;
         var _loc5_:int = 0;
         var _loc3_:StelesysFuzhuBox = null;
         var _loc6_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.mainBg");
         _leftVbox1 = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.main.leftBox1");
         _middleVbox1 = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.main.middleBox1");
         _simpleList = ComponentFactory.Instance.creatCustomObject("stelesys.main.equipList",[3]);
         _mainBox = ComponentFactory.Instance.creatCustomObject("stelesys.HexinBox");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.mainStelaNameTxt");
         _skillItem = ComponentFactory.Instance.creatCustomObject("ui.stelesys.main.skillItem");
         _lineBox = ComponentFactory.Instance.creatCustomObject("ui.stela.mainLineBox");
         addChild(_bg);
         addChild(_leftVbox1);
         addChild(_middleVbox1);
         addChild(_simpleList);
         addChild(_mainBox);
         addChild(_nameTxt);
         addChild(_skillItem);
         addChild(_lineBox);
         _lineBox.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < 10)
         {
            _loc1_ = new StelesysNameAndValueTxt("ui.stelesys.attNameTxt","ui.stelesys.attValueTxt");
            _loc2_ = new StelesysNameAndValueTxt("ui.stelesys.attNameTxt","ui.stelesys.attValueTxt");
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.stela.mainline");
            _leftItemList[_loc5_] = _loc1_;
            _middleItemList[_loc5_] = _loc2_;
            _leftVbox1.addChild(_loc1_);
            _middleVbox1.addChild(_loc2_);
            _lineBox.addChild(_loc4_);
            _loc5_++;
         }
         _lineBox.commitChanges();
         _mainBox.pos = 1;
         _itemList = new Vector.<StelesysFuzhuBox>();
         _loc6_ = 0;
         while(_loc6_ < 9)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("stelesys.fuzhuBox");
            _loc3_.pos = _loc6_ + 2;
            _itemList[_loc6_] = _loc3_;
            _simpleList.addChild(_loc3_);
            _loc6_++;
         }
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("STELE_SYS_CHOOSE",chooseHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_UPDATA",upDataHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("STELE_SYS_CHOOSE",chooseHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_UPDATA",upDataHandler);
      }
      
      private function chooseHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:Array = null;
         var _loc3_:StelesysInfo = param1.data as StelesysInfo;
         if(_loc3_)
         {
            _loc2_ = model.equipList;
            for each(var _loc4_:StelesysInfo in _loc2_)
            {
               if(_loc4_.templateId == _loc3_.templateId)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.equip.same"));
                  return;
               }
            }
            SteleSysManager.Ins.sendEquip(_loc3_.id,model.operPos);
         }
      }
      
      private function upDataHandler(param1:NotificationEvent = null) : void
      {
         var _loc6_:StelesysInfo = null;
         var _loc3_:int = 0;
         var _loc5_:Array = model.equipList;
         var _loc7_:StelesysInfo = _loc5_[0];
         if(_loc7_ && _loc7_.pos != 1)
         {
            _loc7_ = null;
         }
         _mainBox.data = _loc7_;
         var _loc2_:int = int(_loc5_.length);
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 9)
         {
            _itemList[_loc4_].data = null;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc6_ = _loc5_[_loc4_];
            _loc3_ = _loc6_.pos - 2;
            if(_loc3_ >= 0)
            {
               _itemList[_loc3_].data = _loc6_;
            }
            _loc4_++;
         }
         updatemainatts(_loc7_);
         updateAllAtts(_loc5_);
      }
      
      private function updatemainatts(param1:StelesysInfo) : void
      {
         var _loc3_:StelesysNameAndValueTxt = null;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            _nameTxt.text = "";
            _middleVbox1.visible = false;
            _skillItem.refreshView(param1);
            return;
         }
         _middleVbox1.visible = true;
         _nameTxt.htmlText = param1.nameStep;
         var _loc4_:StelaAttInfo = param1.stelaAttInfo;
         var _loc2_:Array = _loc4_.hasValueAtt;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc5_];
            _loc3_ = _middleItemList[_loc5_];
            _loc3_.nameTxt = _loc6_;
            _loc3_.valueTxt = _loc4_[_loc6_];
            _loc5_++;
         }
         _skillItem.refreshView(param1);
      }
      
      private function updateAllAtts(param1:Array) : void
      {
         var _loc7_:StelaAttInfo = null;
         var _loc4_:StelaAttInfo = null;
         var _loc3_:StelesysNameAndValueTxt = null;
         var _loc8_:String = null;
         var _loc5_:int = 0;
         var _loc6_:StelaAttInfo = new StelaAttInfo();
         for each(var _loc9_:StelesysInfo in param1)
         {
            _loc7_ = _loc9_.stelaAttInfo;
            _loc6_.Attack += _loc7_.Attack;
            _loc6_.Defence += _loc7_.Defence;
            _loc6_.MagicAttack += _loc7_.MagicAttack;
            _loc6_.MagicDefence += _loc7_.MagicDefence;
            _loc6_.Live += _loc7_.Live;
            _loc6_.ForceHit += _loc7_.ForceHit;
            _loc6_.Parry += _loc7_.Parry;
            _loc6_.Penetrate += _loc7_.Penetrate;
            _loc6_.ReduceResiAgainst += _loc7_.ReduceResiAgainst;
            _loc6_.ResiPenetrate += _loc7_.ResiPenetrate;
            _loc4_ = _loc9_.skillAttInfo;
            _loc6_.Attack += _loc4_.Attack;
            _loc6_.Defence += _loc4_.Defence;
            _loc6_.MagicAttack += _loc4_.MagicAttack;
            _loc6_.MagicDefence += _loc4_.MagicDefence;
            _loc6_.Live += _loc4_.Live;
            _loc6_.ForceHit += _loc4_.ForceHit;
            _loc6_.Parry += _loc4_.Parry;
            _loc6_.Penetrate += _loc4_.Penetrate;
            _loc6_.ReduceResiAgainst += _loc4_.ReduceResiAgainst;
            _loc6_.ResiPenetrate += _loc4_.ResiPenetrate;
         }
         var _loc2_:Array = _loc6_.allValueAtt;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc8_ = _loc2_[_loc5_];
            _loc3_ = _leftItemList[_loc5_];
            _loc3_.nameTxt = _loc8_;
            _loc3_.valueTxt = _loc6_[_loc8_];
            _loc5_++;
         }
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
      
      private function previewHandle(param1:MouseEvent) : void
      {
         if(model.allStelaList.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.switch.noTip"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("stelesys","switch.page",0);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftVbox1);
         _leftVbox1 = null;
         ObjectUtils.disposeObject(_middleVbox1);
         _middleVbox1 = null;
         ObjectUtils.disposeObject(_simpleList);
         _simpleList = null;
         ObjectUtils.disposeObject(_mainBox);
         _mainBox = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_skillItem);
         _skillItem = null;
         ObjectUtils.disposeObject(_lineBox);
         _lineBox = null;
         _leftItemList = null;
         _middleItemList = null;
         super.dispose();
      }
   }
}

