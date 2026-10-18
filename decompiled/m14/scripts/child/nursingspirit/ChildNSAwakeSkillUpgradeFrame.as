package child.nursingspirit
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.BulePowerItem;
   
   public class ChildNSAwakeSkillUpgradeFrame extends Frame
   {
      
      private var back:MutipleImage;
      
      private var nsIcon:BaseIconView;
      
      private var expItem:BulePowerItem;
      
      private var materialItem:BaseItemView;
      
      private var curMaterialText:FilterFrameText;
      
      private var costMaterialText:FilterFrameText;
      
      private var curMaterialValueText:FilterFrameText;
      
      private var costMaterialValueText:FilterFrameText;
      
      private var curAttVbox:VBox;
      
      private var nextAttVbox:VBox;
      
      private var maxImage:Bitmap;
      
      private var curSkillIcon:BaseIconView;
      
      private var nextSkillIcon:BaseIconView;
      
      private var awakeBtn:IconButton;
      
      private var descText:FilterFrameText;
      
      private var txtValueArr:Array;
      
      private var materialTempId:int;
      
      private var curUpgradeTemp:UpgradeTemplateInfo;
      
      private var nextUpgradeTemp:UpgradeTemplateInfo;
      
      public function ChildNSAwakeSkillUpgradeFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.back");
         nsIcon = ComponentFactory.Instance.creatCustomObject("ChildNSAwakeSkillUpgradeFrame.nsIcon");
         expItem = ComponentFactory.Instance.creatCustomObject("ChildNSAwakeSkillUpgradeFrame.expItem");
         materialItem = ComponentFactory.Instance.creatCustomObject("ChildNSAwakeSkillUpgradeFrame.materialItem");
         curMaterialText = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.curMaterialText");
         costMaterialText = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.costMaterialText");
         curMaterialValueText = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.curMaterialValueText");
         costMaterialValueText = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.costMaterialValueText");
         curAttVbox = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.curAttVbox");
         nextAttVbox = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.nextAttVbox");
         maxImage = ComponentFactory.Instance.creatBitmap("asset.ChildNSAwakeSkillUpgradeFrame.maxImage");
         curSkillIcon = ComponentFactory.Instance.creatCustomObject("ChildNSAwakeSkillUpgradeFrame.curSkillIcon");
         nextSkillIcon = ComponentFactory.Instance.creatCustomObject("ChildNSAwakeSkillUpgradeFrame.nextSkillIcon");
         awakeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.awakeBtn");
         descText = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.descText");
         addToContent(back);
         addToContent(nsIcon);
         addToContent(expItem);
         addToContent(materialItem);
         addToContent(curMaterialText);
         addToContent(costMaterialText);
         addToContent(curMaterialValueText);
         addToContent(costMaterialValueText);
         addToContent(curAttVbox);
         addToContent(nextAttVbox);
         addToContent(maxImage);
         addToContent(curSkillIcon);
         addToContent(nextSkillIcon);
         addToContent(awakeBtn);
         addToContent(descText);
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = 212014;
         materialItem.data = _loc1_;
         curMaterialText.text = LanguageMgr.GetTranslation("child.attribute.ChildUpgradeGrowthView.numTitle1");
         costMaterialText.text = LanguageMgr.GetTranslation("child.attribute.ChildUpgradeGrowthView.numTitle2");
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(212014);
         if(_loc2_)
         {
            descText.text = LanguageMgr.GetTranslation("ChildNSAwakeSkillUpgradeFrame.descText.text",_loc2_.TemplateName);
         }
         txtValueArr = LanguageMgr.GetTranslation("child.attribute.ChildUpgradeGrowthView.attName").split("|");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         costMaterialValueText.addEventListener("change",__txtChangeHandler);
         awakeBtn.addEventListener("click",__awakeBtnClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoChildHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(costMaterialValueText)
         {
            costMaterialValueText.removeEventListener("change",__txtChangeHandler);
         }
         if(awakeBtn)
         {
            awakeBtn.removeEventListener("click",__awakeBtnClickHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoChildHandler);
      }
      
      private function __childInfoChildHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __txtChangeHandler(param1:Event) : void
      {
         var _loc2_:int = int(GoodsManager.instance.getBagCountByTempId(1,212014));
         var _loc3_:int = parseInt(costMaterialValueText.text);
         if(_loc3_)
         {
            if(_loc3_ > _loc2_)
            {
               _loc3_ = _loc2_;
            }
         }
         else
         {
            _loc3_ = 1;
         }
         if(_loc2_ > 0)
         {
            costMaterialValueText.text = _loc3_ + "";
         }
         else
         {
            costMaterialValueText.text = "0";
         }
      }
      
      private function __awakeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = parseInt(costMaterialValueText.text);
         ChildSender.nsUpgradeAwakeSkill(nsData.childId,_loc2_);
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:FilterFrameText = null;
         var _loc5_:SkillTempInfo = null;
         var _loc2_:FilterFrameText = null;
         maxImage.visible = false;
         curAttVbox.disposeAllChildren();
         nextAttVbox.disposeAllChildren();
         if(!nsData || !nsData.nursingSpiritInfo)
         {
            return;
         }
         var _loc6_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(nsData.job,nsData.growthGrade);
         nsIcon.icon = PathManager.info.ResourcePath + "icon" + _loc6_.Icon;
         curMaterialValueText.text = GoodsManager.instance.getBagCountByTempId(1,212014) + "";
         costMaterialValueText.text = curMaterialValueText.text;
         curUpgradeTemp = TempleteManager.instance.getTemplateByLevelAndType(nsData.nursingSpiritInfo.awakeGrade,135);
         nextUpgradeTemp = TempleteManager.instance.getTemplateByLevelAndType(nsData.nursingSpiritInfo.awakeGrade + 1,135);
         var _loc4_:SkillTempInfo = nsModel.getAwakeSkillTempByGrade(nsData);
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.addValueTxt");
            if(nextUpgradeTemp)
            {
               _loc5_ = nsModel.getAwakeSkillTempByGrade(nsData,true);
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ChildNSAwakeSkillUpgradeFrame.addValueTxt");
               _loc2_.text = txtValueArr[_loc3_] + ": " + nextUpgradeTemp.TemplateName.split(",")[_loc3_] + "%";
               _loc2_.setFrame(2);
               nextAttVbox.addChild(_loc2_);
            }
            _loc1_.text = txtValueArr[_loc3_] + ": " + curUpgradeTemp.TemplateName.split(",")[_loc3_] + "%";
            _loc1_.setFrame(1);
            curAttVbox.addChild(_loc1_);
            _loc3_++;
         }
         if(nextUpgradeTemp)
         {
            awakeBtn.enable = true;
            nextSkillIcon.visible = true;
            nextSkillIcon.icon = IconFactory.getTecIconByIcon(_loc5_.Icons);
            nextSkillIcon.tipData = _loc5_;
            expItem.max = nextUpgradeTemp.Data;
            expItem.current = nsData.nursingSpiritInfo.awakeGp;
         }
         else
         {
            awakeBtn.enable = false;
            nextSkillIcon.visible = false;
            maxImage.visible = true;
            expItem.full = true;
            expItem.setText("Max");
         }
         if(GoodsManager.instance.getBagCountByTempId(1,212014) <= 0)
         {
            awakeBtn.enable = false;
         }
         curSkillIcon.icon = IconFactory.getTecIconByIcon(_loc4_.Icons);
         curSkillIcon.tipData = _loc4_;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get nsData() : ChildData
      {
         return nsModel.selectedNsChild;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         titleText = LanguageMgr.GetTranslation("ChildNSAwakeSkillUpgradeFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(nsIcon);
         nsIcon = null;
         ObjectUtils.disposeObject(expItem);
         expItem = null;
         ObjectUtils.disposeObject(materialItem);
         materialItem = null;
         ObjectUtils.disposeObject(curMaterialText);
         curMaterialText = null;
         ObjectUtils.disposeObject(costMaterialText);
         costMaterialText = null;
         ObjectUtils.disposeObject(curMaterialValueText);
         curMaterialValueText = null;
         ObjectUtils.disposeObject(costMaterialValueText);
         costMaterialValueText = null;
         ObjectUtils.disposeObject(curAttVbox);
         curAttVbox = null;
         ObjectUtils.disposeObject(nextAttVbox);
         nextAttVbox = null;
         ObjectUtils.disposeObject(maxImage);
         maxImage = null;
         ObjectUtils.disposeObject(curSkillIcon);
         curSkillIcon = null;
         ObjectUtils.disposeObject(nextSkillIcon);
         nextSkillIcon = null;
         ObjectUtils.disposeObject(awakeBtn);
         awakeBtn = null;
         ObjectUtils.disposeObject(descText);
         descText = null;
         super.dispose();
      }
   }
}

