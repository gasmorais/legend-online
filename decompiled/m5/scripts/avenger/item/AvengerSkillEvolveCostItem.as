package avenger.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerSkillInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.AvengerSkillTempInfo;
   import yishi.manager.AvengerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerSkillEvolveCostItem extends Component
   {
      
      private var _fullText:FilterFrameText;
      
      private var _progressText:FilterFrameText;
      
      private var _costItem:BaseItemView;
      
      private var _promotBtn:TextButton;
      
      private var index:int;
      
      private var _data:AvengerSkillInfo;
      
      private var tempId:int;
      
      private var needCount:int;
      
      private var hasCount:int;
      
      public function AvengerSkillEvolveCostItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _fullText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolveCostItem.fullText");
         _progressText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolveCostItem.progressText");
         _costItem = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillEvolveCostItem.costItem");
         _promotBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolveCostItem.promotBtn");
         addChild(_costItem);
         addChild(_progressText);
         addChild(_fullText);
         addChild(_promotBtn);
         _promotBtn.text = LanguageMgr.GetTranslation("AvengerSkillEvolveCostItem.promotBtn.text");
      }
      
      private function addEvent() : void
      {
         _promotBtn.addEventListener("click",_promotBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_promotBtn)
         {
            _promotBtn.removeEventListener("click",_promotBtnClickHandler);
         }
      }
      
      private function _promotBtnClickHandler(param1:MouseEvent) : void
      {
         if(hasCostCount >= needCount || !data)
         {
            return;
         }
         if(hasCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         AvengerManager.instance.sendAvengerSkillPromote(data.skillSontype,tempId);
      }
      
      public function get data() : AvengerSkillInfo
      {
         return _data;
      }
      
      public function set data(param1:AvengerSkillInfo) : void
      {
         _data = param1;
         if(!data)
         {
            return;
         }
         var _loc2_:AvengerSkillTempInfo = TempleteManager.instance.avengerSkillTempCate.getTemplateByTypeAndGrade(data.skillSontype,data.skillTemp.Grades);
         if(!_loc2_)
         {
            return;
         }
         tempId = _loc2_.needItemAry[0][index];
         needCount = _loc2_.needItemAry[1][index];
         hasCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(tempId);
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = tempId;
         _loc3_.count = hasCount;
         _costItem.data = _loc3_;
         if(hasCount <= 0)
         {
            _costItem.setItemTextOther("0");
         }
         if(hasCostCount >= needCount)
         {
            _promotBtn.visible = false;
            _fullText.text = LanguageMgr.GetTranslation("AvengerSkillEvolveCostItem.fullText.text");
            _progressText.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolveCostItem.progressText.text2",hasCostCount,needCount);
         }
         else
         {
            _promotBtn.visible = true;
            _fullText.text = "";
            _progressText.htmlText = LanguageMgr.GetTranslation("AvengerSkillEvolveCostItem.progressText.text1",hasCostCount,needCount);
         }
      }
      
      public function get hasReached() : Boolean
      {
         return hasCostCount >= needCount;
      }
      
      private function get hasCostCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         var _loc3_:Array = data.needItems.split("|");
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc2_].split(",");
            if(int(_loc1_[0]) == tempId)
            {
               return _loc1_[1];
            }
            _loc2_++;
         }
         return 0;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_fullText);
         _fullText = null;
         ObjectUtils.disposeObject(_progressText);
         _progressText = null;
         ObjectUtils.disposeObject(_costItem);
         _costItem = null;
         ObjectUtils.disposeObject(_promotBtn);
         _promotBtn = null;
         super.dispose();
      }
   }
}

