package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import mvc.module.children.NursingSpiritInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNSTalentView extends Component
   {
      
      private var back:MutipleImage;
      
      private var talentLvlText:FilterFrameText;
      
      private var lvlContiner:Component;
      
      private var numBitmap:BitmapData;
      
      private var itemContnier:Component;
      
      private var needMaterialText:FilterFrameText;
      
      private var hasMaterialText:FilterFrameText;
      
      private var upgradeBtn:IconButton;
      
      private var talentList:Vector.<ChildNSTalentItemView>;
      
      private var posArr:Array = [[20,110],[55,192],[149,225],[222,146],[334,133],[426,80],[477,168]];
      
      private var nsInfo:NursingSpiritInfo;
      
      private var curUpgradeTemp:UpgradeTemplateInfo;
      
      private var nextUpgradeTemp:UpgradeTemplateInfo;
      
      private var hasMaterialCount:int;
      
      private var needMaterialCount:int;
      
      public function ChildNSTalentView()
      {
         super();
         initView();
         initItemListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentView.back");
         talentLvlText = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentView.talentLvlText");
         numBitmap = ComponentFactory.Instance.creatBitmapData("asset.ChildNSTalentView.numBitmap");
         lvlContiner = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentView.lvlContiner");
         itemContnier = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentView.itemContnier");
         needMaterialText = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentView.needMaterialText");
         hasMaterialText = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentView.hasMaterialText");
         upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentView.upgradeBtn");
         addChild(back);
         addChild(talentLvlText);
         addChild(lvlContiner);
         addChild(itemContnier);
         addChild(needMaterialText);
         addChild(hasMaterialText);
         addChild(upgradeBtn);
      }
      
      private function initItemListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildNSTalentItemView = null;
         talentList = new Vector.<ChildNSTalentItemView>();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildNSTalentView.item",[_loc2_]);
            _loc1_.x = posArr[_loc2_][0];
            _loc1_.y = posArr[_loc2_][1];
            itemContnier.addChild(_loc1_);
            talentList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         upgradeBtn.addEventListener("click",__upgradeClickHandler);
      }
      
      private function removeEvent() : void
      {
         upgradeBtn.removeEventListener("click",__upgradeClickHandler);
      }
      
      private function __upgradeClickHandler(param1:MouseEvent) : void
      {
         if(!nextUpgradeTemp)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNSTalentView.upgradeBtn.maxAlert"));
            return;
         }
         if(hasMaterialCount < needMaterialCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNSTalentView.upgradeBtn.noMaterial"));
            return;
         }
         ChildSender.nsUpgradeTalent(36,nsModel.selectedNsChild.childId);
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         nsInfo = nsModel.selectedNsChild.nursingSpiritInfo;
         if(!nsInfo)
         {
            dispose();
            return;
         }
         curUpgradeTemp = TempleteManager.instance.getTemplateByLevelAndType(nsInfo.talentGrade,132);
         nextUpgradeTemp = TempleteManager.instance.getTemplateByLevelAndType(nsInfo.talentGrade + 1,132);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(212011);
         hasMaterialCount = GoodsManager.instance.getGoodsNumByTempId(212011);
         if(nextUpgradeTemp)
         {
            needMaterialCount = nextUpgradeTemp.Data;
         }
         else
         {
            needMaterialCount = 0;
         }
         talentLvlText.text = nsInfo.talentPoint + "";
         NumberViewUtils.refreshValue(nsInfo.talentGrade,lvlContiner,numBitmap,19,21,16,19,"0123456789");
         needMaterialText.htmlText = LanguageMgr.GetTranslation("ChildNSTalentView.needMaterialText.text",_loc1_.TemplateName,needMaterialCount);
         hasMaterialText.htmlText = LanguageMgr.GetTranslation("ChildNSTalentView.hasMaterialText.text",_loc1_.TemplateName,hasMaterialCount);
         _loc2_ = 0;
         while(_loc2_ < talentList.length)
         {
            if(nsInfo.lvlIndexDic && nsInfo.lvlIndexDic[_loc2_])
            {
               talentList[_loc2_].level = int(nsInfo.lvlIndexDic[_loc2_]);
            }
            else
            {
               talentList[_loc2_].level = 0;
            }
            _loc2_++;
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(talentLvlText);
         talentLvlText = null;
         ObjectUtils.disposeObject(lvlContiner);
         lvlContiner = null;
         ObjectUtils.disposeObject(numBitmap);
         numBitmap = null;
         ObjectUtils.disposeObject(itemContnier);
         itemContnier = null;
         ObjectUtils.disposeObject(needMaterialText);
         needMaterialText = null;
         ObjectUtils.disposeObject(hasMaterialText);
         hasMaterialText = null;
         ObjectUtils.disposeObject(upgradeBtn);
         upgradeBtn = null;
         LogicUtils.disposeDisplayCollection(talentList);
         talentList = null;
         super.dispose();
      }
   }
}

