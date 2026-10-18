package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChildNsFMSkillIconView extends Sprite
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _skillIcon:BaseIconView;
      
      private var _idxBg:ScaleFrameImage;
      
      private var _ldxTxt:FilterFrameText;
      
      private var _lvTxt:FilterFrameText;
      
      private var _lock:Image;
      
      private var _addBtn:BaseButton;
      
      private var _idx:int;
      
      private var _chData:ChildData;
      
      private var _buffLvMax:Array = [1,1,1,1,1];
      
      public function ChildNsFMSkillIconView(param1:int)
      {
         super();
         _idx = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildNsFMSkillIconView.bg");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("ChildNsFMSkillIconView.icon");
         _idxBg = ComponentFactory.Instance.creatComponentByStylename("ChildNsFMSkillIconView.lvBg");
         _ldxTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpirit.ns.sklvText");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerChildNsPropItem.addBtn");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNSFrame.fmLvTxt");
         _lock = ComponentFactory.Instance.creatComponentByStylename("ChildNsFMSkillIconView.lock");
         addChild(_bg);
         addChild(_skillIcon);
         addChild(_lock);
         addChild(_idxBg);
         addChild(_ldxTxt);
         addChild(_addBtn);
         addChild(_lvTxt);
         _ldxTxt.text = "" + _idx;
      }
      
      private function getMaxGrade(param1:SkillTempInfo) : int
      {
         var _loc2_:Array = TempleteManager.instance.getChildSkillsByMasterTypeAndSonType(param1.MasterType,param1.SonType);
         return _loc2_[_loc2_.length - 1].Grades;
      }
      
      private function initEvent() : void
      {
         _addBtn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _addBtn.removeEventListener("click",clickHandler);
         _skillIcon.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit","NS_BUFF",[_idx - 1,_chData]);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_idxBg);
         _idxBg = null;
         ObjectUtils.disposeObject(_ldxTxt);
         _ldxTxt = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _chData = null;
         _buffLvMax = null;
      }
      
      public function updateBuffGradeMax(param1:Array) : void
      {
         _buffLvMax = param1;
      }
      
      public function set chData(param1:ChildData) : void
      {
         var _loc7_:String = null;
         var _loc2_:Array = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         var _loc3_:SkillTempInfo = null;
         _chData = param1;
         if(_chData)
         {
            _loc7_ = _chData.nursingSpiritInfo.trainInfo.skills;
            _loc2_ = _loc7_.split(",");
            _loc4_ = _loc2_[_idx - 1];
            if(_loc4_ == "-1")
            {
               _lock.visible = true;
               _addBtn.visible = false;
               _lvTxt.text = "";
               _loc6_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName0" + _idx);
               _lock.tipData = LanguageMgr.GetTranslation("childnsFm.unLock",_loc6_);
            }
            else
            {
               _lock.visible = false;
               _loc5_ = int(_loc4_);
               if(_loc5_ > 0)
               {
                  _addBtn.visible = true;
                  _loc3_ = TempleteManager.instance.getSkillById(_loc5_);
                  if(_loc3_.Grades >= int(_buffLvMax[_idx - 1]))
                  {
                     _addBtn.visible = false;
                  }
                  if(_idx == 5 && _loc3_.Grades >= 4 && _chData.nursingSpiritInfo.trainInfo.profileGrade < 5)
                  {
                     _addBtn.visible = false;
                  }
                  _lvTxt.text = _loc3_.Grades + "/" + getMaxGrade(_loc3_);
                  _skillIcon.icon = IconFactory.getTecIconByIcon(_loc3_.Icons);
                  _skillIcon.tipData = _loc3_;
                  _skillIcon.removeEventListener("click",clickHandler);
                  _skillIcon.addEventListener("click",clickHandler);
               }
               else
               {
                  _skillIcon.removeEventListener("click",clickHandler);
                  _addBtn.visible = true;
                  _lvTxt.text = "";
               }
            }
         }
      }
   }
}

