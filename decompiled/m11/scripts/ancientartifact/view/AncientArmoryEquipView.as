package ancientartifact.view
{
   import ancientartifact.view.item.AncientEquipArmoryItem;
   import ancientartifact.view.item.AncientResonateItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.AncientArtifactEvent;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class AncientArmoryEquipView extends Component
   {
      
      private static const itemPosList01:Array = [{
         "x":140,
         "y":36
      },{
         "x":258,
         "y":90
      },{
         "x":258,
         "y":200
      },{
         "x":21,
         "y":200
      },{
         "x":21,
         "y":90
      },{
         "x":140,
         "y":144
      }];
      
      private static const itemPosList02:Array = [{
         "x":15,
         "y":356
      },{
         "x":75,
         "y":356
      },{
         "x":135,
         "y":356
      },{
         "x":195,
         "y":356
      },{
         "x":255,
         "y":356
      },{
         "x":315,
         "y":356
      }];
      
      private static const posList:Array = [6,1,2,3,4,5];
      
      private var _backBg:Bitmap;
      
      private var _armoryList:Array;
      
      private var _resonateList:Array;
      
      private var _titleTxt:FilterFrameText;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _skillTxt:FilterFrameText;
      
      private var _templateId:int;
      
      private var _data:AncientArtifactInfo;
      
      public function AncientArmoryEquipView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function initView() : void
      {
         var _loc2_:AncientEquipArmoryItem = null;
         var _loc1_:AncientResonateItem = null;
         var _loc3_:int = 0;
         _backBg = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryEquipBg01");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryTitleTxt1");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryTipsTxt");
         _skillTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armorySkillTxt");
         addChild(_backBg);
         addChild(_titleTxt);
         addChild(_tipsTxt);
         addChild(_skillTxt);
         _armoryList = [];
         _resonateList = [];
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientEquipArmoryItem",[posList[_loc3_]]);
            addChild(_loc2_);
            _loc2_.x = itemPosList02[_loc3_].x;
            _loc2_.y = itemPosList02[_loc3_].y;
            _armoryList.push(_loc2_);
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientResonateItem",[_loc3_ + 1]);
            addChild(_loc1_);
            _loc1_.x = itemPosList01[_loc3_].x;
            _loc1_.y = itemPosList01[_loc3_].y;
            _resonateList.push(_loc1_);
            _loc3_ += 1;
         }
         _titleTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryTitle1");
         _tipsTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryEquipTips01");
         initEquipArmoryInfos();
         initResonateInfos();
      }
      
      private function initEvent() : void
      {
         model.addEventListener("ARMORY_EQUIP_BAG_UP_DATA",__updataBagInfo);
         model.addEventListener("RESONATE_INFO_UP_DATA",__updataResonateInfo);
         NotificationManager.instance.addEventListener("ARTIFACT_ITEM_CLICK",__updataInfo);
         NotificationManager.instance.addEventListener("ARTIFACT_INFO_UPDATE",__updataInfo);
      }
      
      private function __updataInfo(param1:NotificationEvent) : void
      {
         initEquipArmoryInfos();
         initResonateInfos();
      }
      
      private function __updataBagInfo(param1:AncientArtifactEvent) : void
      {
         initEquipArmoryInfos();
         initResonateInfos();
      }
      
      private function __updataResonateInfo(param1:AncientArtifactEvent) : void
      {
         initEquipArmoryInfos();
         initResonateInfos();
      }
      
      private function initResonateInfos() : void
      {
         var _loc1_:AncientResonateItem = null;
         var _loc3_:int = 0;
         _templateId = AncientArtifactManager.instance.selectTempId;
         var _loc2_:AncientResonateItem = _resonateList[_resonateList.length - 1] as AncientResonateItem;
         _loc2_.anctientId = _templateId;
         _data = model.getArtifactInfoById(_templateId);
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc1_ = _resonateList[_loc3_];
            if(_data && _data["slotedEquipPos" + (_loc3_ + 1)] > 0)
            {
               _loc1_.anctientId = _data["slotedEquipPos" + (_loc3_ + 1)];
               setItemStae(_loc3_ + 1,false);
            }
            else
            {
               _loc1_.anctientId = 0;
               setItemStae(_loc3_ + 1,true);
            }
            _loc3_ += 1;
         }
         if(_data)
         {
            setItemStae(6,false);
         }
         else
         {
            setItemStae(6,true);
         }
      }
      
      private function initEquipArmoryInfos() : void
      {
         var _loc2_:AncientEquipArmoryItem = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:Array = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:SkillTempInfo = null;
         _templateId = AncientArtifactManager.instance.selectTempId;
         _data = model.getArtifactInfoById(_templateId);
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc2_ = _armoryList[_loc4_];
            _loc8_ = int(_data ? _data["armoryEquipPos" + _loc2_.pos] : 0);
            if(_loc8_ > 0)
            {
               _loc2_.data = model.getArmoryInfoById(_loc8_);
            }
            else
            {
               _loc2_.data = null;
            }
            _loc4_ += 1;
         }
         var _loc1_:String = "";
         if(_data)
         {
            _loc6_ = _data.skillList ? _data.skillList.split(",") : [];
            _loc3_ = int(_loc6_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc7_ = TempleteManager.instance.getSkillTemplateInfoById(int(_loc6_[_loc5_]));
               if(_loc7_)
               {
                  _loc1_ += _loc7_.Description + "\n";
               }
               _loc5_ += 1;
            }
         }
         _skillTxt.htmlText = _loc1_;
      }
      
      private function setItemStae(param1:int, param2:Boolean) : void
      {
         var _loc3_:AncientEquipArmoryItem = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc3_ = _armoryList[_loc4_];
            if(_loc3_.pos == param1)
            {
               _loc3_.isLock = param2;
            }
            _loc4_ += 1;
         }
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("ARMORY_EQUIP_BAG_UP_DATA",__updataBagInfo);
         model.removeEventListener("RESONATE_INFO_UP_DATA",__updataResonateInfo);
         NotificationManager.instance.removeEventListener("ARTIFACT_ITEM_CLICK",__updataInfo);
         NotificationManager.instance.removeEventListener("ARTIFACT_INFO_UPDATE",__updataInfo);
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_backBg);
         _backBg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_skillTxt);
         _skillTxt = null;
         LogicUtils.disposeDisplayCollection(_resonateList);
         _resonateList = null;
         LogicUtils.disposeDisplayCollection(_armoryList);
         _armoryList = null;
         super.dispose();
      }
   }
}

