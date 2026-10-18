package monster.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.MonsterManager;
   
   public class MonsterTrainItem extends Component
   {
      
      private var _descText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _avatar:MonsterShowAvatar;
      
      private var _data:MonsterInfo;
      
      private var preType:String;
      
      public function MonsterTrainItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrainItem.nameText");
         _descText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterTrainItem.descText");
         _avatar = new MonsterShowAvatar();
         _avatar.mouseChildren = _avatar.mouseEnabled = false;
         addChild(_avatar);
         addChild(_nameText);
         addChild(_descText);
      }
      
      public function get data() : MonsterInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterInfo) : void
      {
         var _loc2_:UpgradeTemplateInfo = null;
         _data = param1;
         if(data)
         {
            _nameText.text = data.name;
            _loc2_ = model.stageUpgradeTempAry[data.stageGrade];
            if(!_loc2_)
            {
               _descText.text = LanguageMgr.GetTranslation("MonsterTrainItem.descText.text",0);
            }
            else
            {
               _descText.text = LanguageMgr.GetTranslation("MonsterTrainItem.descText.text",_loc2_.ActiveObject);
            }
            if(preType != data.type + "_" + data.star || _avatar.data == null)
            {
               _avatar.data = data.tempInfo;
            }
            _avatar.setBodyScale(data.tempInfo.Scale / 100);
            _avatar.x = _avatar.getPosLeg().x + 78;
            _avatar.y = _avatar.getPosLeg().y + 185 + data.tempInfo.Offset;
            preType = data.type + "_" + data.star;
         }
         else
         {
            _nameText.text = "";
            _descText.text = "";
            _avatar.data = null;
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         super.dispose();
      }
   }
}

