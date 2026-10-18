package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.remotepet.RemotePetModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   
   public class RemoteSkillView extends Component
   {
      
      private var _title:Bitmap;
      
      private var _hBox:HBox;
      
      private var _text1:FilterFrameText;
      
      private var _text2:FilterFrameText;
      
      private var _skillList:Array;
      
      public function RemoteSkillView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:SkillInfo = null;
         var _loc2_:RemoteSkillItemView = null;
         _skillList = [];
         _title = ComponentFactory.Instance.creatBitmap("asset.remotepet.skillTitle");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("remotepet.skill.hBox");
         _text1 = ComponentFactory.Instance.creatComponentByStylename("remotepet.SkillView.text1");
         _text2 = ComponentFactory.Instance.creatComponentByStylename("remotepet.SkillView.text2");
         addChild(_title);
         addChild(_hBox);
         addChild(_text1);
         addChild(_text2);
         var _loc4_:Vector.<SkillTempInfo> = TempleteManager.instance.getRemotePetSkill();
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc1_ = new SkillInfo();
            _loc2_ = new RemoteSkillItemView();
            _hBox.addChild(_loc2_);
            _loc1_.templateId = _loc4_[_loc3_].TemplateId;
            _loc1_.grade = 0;
            _loc2_.data = _loc1_;
            _skillList.push(_loc2_);
            _loc3_++;
         }
         __commitHandler(null);
      }
      
      private function __commitHandler(param1:RemotePetEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:SkillInfo = null;
         var _loc6_:Array = model.remotePetSkill;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc3_ = new SkillInfo();
            _loc3_.templateId = _loc6_[_loc5_];
            _loc3_.grade = _loc3_.templateInfo.Grades;
            _skillList[_loc5_].data = _loc3_;
            _loc5_++;
         }
         var _loc4_:int = int(GoodsManager.instance.getGoodsNumByTempId(2131200));
         var _loc2_:int = int(GoodsManager.instance.getGoodsNumByTempId(2131201));
         _text1.text = LanguageMgr.GetTranslation("remotepet.SkillView.text1") + " " + _loc4_;
         _text2.text = LanguageMgr.GetTranslation("remotepet.SkillView.text2") + " " + _loc2_;
      }
      
      private function addEvent() : void
      {
         model.addEventListener("COMMIT",__commitHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("COMMIT",__commitHandler);
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      private function uintView() : void
      {
         var _loc1_:RemoteSkillItemView = null;
         if(_hBox)
         {
            _hBox.disposeAllChildren();
         }
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_text1);
         _text1 = null;
         ObjectUtils.disposeObject(_text2);
         _text2 = null;
         if(_skillList)
         {
            _loc1_ = _skillList.pop() as RemoteSkillItemView;
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         _skillList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

