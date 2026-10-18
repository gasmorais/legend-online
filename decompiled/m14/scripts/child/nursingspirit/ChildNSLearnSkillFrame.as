package child.nursingspirit
{
   import child.skill.ChildSkillItemView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   import yishi.view.community.BulePowerItem;
   import yishi.view.frame.BuyFrameI;
   
   public class ChildNSLearnSkillFrame extends Frame
   {
      
      private var back:MutipleImage;
      
      private var skillItem:ChildSkillItemView;
      
      private var skillName:FilterFrameText;
      
      private var hasMaterialText:FilterFrameText;
      
      private var needMaterialBar:BulePowerItem;
      
      private var inputBack:ScaleBitmapImage;
      
      private var inputText:FilterFrameText;
      
      private var learnBtn:IconButton;
      
      private var showType:int;
      
      private var skillTemp:SkillTempInfo;
      
      private var maxSkillBookCount:int;
      
      private var curSkillBookCount:int;
      
      private var curLearnSkill:SkillTempInfo;
      
      private var hasMaterialCount:int;
      
      private var needTempId:int;
      
      private var maxGrade:int;
      
      public function ChildNSLearnSkillFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildNSLearnSkillFrame.back");
         skillItem = ComponentFactory.Instance.creatCustomObject("ChildNSLearnSkillFrame.skillItem");
         skillName = ComponentFactory.Instance.creatComponentByStylename("ChildNSLearnSkillFrame.skillName");
         needMaterialBar = ComponentFactory.Instance.creatCustomObject("ChildNSLearnSkillFrame.needMaterialBar",[true]);
         hasMaterialText = ComponentFactory.Instance.creatComponentByStylename("ChildNSLearnSkillFrame.hasMaterialText");
         inputBack = ComponentFactory.Instance.creatComponentByStylename("ChildNSLearnSkillFrame.inputBack");
         inputText = ComponentFactory.Instance.creatComponentByStylename("ChildNSLearnSkillFrame.inputText");
         learnBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSLearnSkillFrame.learnBtn");
         addToContent(back);
         addToContent(skillItem);
         addToContent(skillName);
         addToContent(needMaterialBar);
         addToContent(hasMaterialText);
         addToContent(inputBack);
         addToContent(inputText);
         addToContent(learnBtn);
         inputText.text = "1";
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         learnBtn.addEventListener("click",__learnSkillHandler);
         inputText.addEventListener("change",__textInputChangeHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(learnBtn)
         {
            learnBtn.removeEventListener("click",__learnSkillHandler);
         }
         if(inputText)
         {
            inputText.removeEventListener("change",__textInputChangeHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
      }
      
      private function __learnSkillHandler(param1:MouseEvent) : void
      {
         if(hasMaterialCount < int(inputText.text))
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
         else if(!curLearnSkill)
         {
            ChildSender.nsUpgradeSkill(33,nsModel.selectedNsChild.childId,learnType,skillTemp.TemplateId);
         }
         else
         {
            ChildSender.nsUpgradeSkill(34,nsModel.selectedNsChild.childId,learnType,curLearnSkill.TemplateId,int(inputText.text));
         }
      }
      
      private function quickUIcallback() : void
      {
         var _loc3_:int = int(inputText.text) - hasMaterialCount;
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(needTempId);
         _loc1_.data(_loc2_,_loc3_);
         _loc1_.callback = buyCallBack;
         _loc1_.show();
      }
      
      private function buyCallBack(param1:Boolean, param2:Object = null) : void
      {
         refreshView();
      }
      
      private function __textInputChangeHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(inputText.text);
         if(_loc2_ <= 0)
         {
            inputText.text = "1";
         }
         if(_loc2_ >= 10000)
         {
            inputText.text = "9999";
         }
         if(!curLearnSkill)
         {
            inputText.text = maxSkillBookCount + "";
         }
      }
      
      private function __childInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:String = null;
         var _loc4_:Array = null;
         curLearnSkill = nsModel.getIsLearnSkillTempInfo(skillTemp,nsModel.getHasLearnSkillStrByType(showType));
         if(!curLearnSkill)
         {
            skillItem.data = skillTemp;
            skillName.text = skillTemp.TemplateName;
            maxGrade = TempleteManager.instance.getSkillsBySonType(skillTemp.SonType).length;
            skillItem.setLvlText("0/" + maxGrade);
            maxSkillBookCount = 1;
            curSkillBookCount = hasMaterialCount >= 1 ? 1 : 0;
            needTempId = nsModel.needMaterialTempIdBySkillTemp(skillTemp,showType);
            learnBtn.enable = skillTemp.Grades < maxGrade;
         }
         else
         {
            skillItem.data = curLearnSkill;
            skillName.text = curLearnSkill.TemplateName;
            maxGrade = TempleteManager.instance.getSkillsBySonType(curLearnSkill.SonType).length;
            skillItem.setLvlText(curLearnSkill.Grades + "/" + maxGrade);
            maxSkillBookCount = nsModel.getSkillUpgradeCostByGrade(curLearnSkill.Grades);
            needTempId = nsModel.needMaterialTempIdBySkillTemp(curLearnSkill,showType);
            learnBtn.enable = curLearnSkill.Grades < maxGrade;
            _loc2_ = nsModel.getHasSkillBooksByType(showType).split("|");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc1_ = _loc2_[_loc3_];
               _loc4_ = _loc1_.split(",");
               if(parseInt(_loc4_[0]) > 0 && parseInt(_loc4_[0]) == curLearnSkill.TemplateId)
               {
                  curSkillBookCount = parseInt(_loc4_[1]);
                  break;
               }
               _loc3_++;
            }
         }
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(needTempId);
         hasMaterialCount = GoodsManager.instance.getGoodsNumByTempId(needTempId);
         hasMaterialText.text = LanguageMgr.GetTranslation("ChildNSLearnSkillFrame.hasMaterialText.text",_loc5_.TemplateName,hasMaterialCount);
         if(curLearnSkill && curLearnSkill.Grades >= maxGrade)
         {
            needMaterialBar.full = true;
            needMaterialBar.setText("Max");
         }
         else
         {
            needMaterialBar.max = maxSkillBookCount;
            needMaterialBar.current = curSkillBookCount;
         }
      }
      
      private function get learnType() : int
      {
         if(showType == 1 || showType == 2)
         {
            return showType;
         }
         return 0;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1 && param1.frameData)
         {
            showType = int(param1.frameData.frameType);
            skillTemp = param1.frameData.skillTempData;
         }
         this.titleText = LanguageMgr.GetTranslation("ChildNSLearnSkillFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         refreshView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(skillItem);
         skillItem = null;
         ObjectUtils.disposeObject(skillName);
         skillName = null;
         ObjectUtils.disposeObject(needMaterialBar);
         needMaterialBar = null;
         ObjectUtils.disposeObject(hasMaterialText);
         hasMaterialText = null;
         ObjectUtils.disposeObject(inputBack);
         inputBack = null;
         ObjectUtils.disposeObject(inputText);
         inputText = null;
         ObjectUtils.disposeObject(learnBtn);
         learnBtn = null;
         super.dispose();
      }
   }
}

