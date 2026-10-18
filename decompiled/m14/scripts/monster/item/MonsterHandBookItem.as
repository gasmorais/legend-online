package monster.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.templates.MonsterTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.MonsterManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class MonsterHandBookItem extends Component implements IManualSize
   {
      
      private var _nameText:FilterFrameText;
      
      private var _back:Image;
      
      private var _avatar:MonsterShowAvatar;
      
      private var _skillHbox:HBox;
      
      private var _data:MonsterTempInfo;
      
      private var preType:String;
      
      public function MonsterHandBookItem()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,179,182);
      }
      
      private function initView() : void
      {
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterHandBookItem.nameText");
         _back = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterHandBookItem.back");
         _skillHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterHandBookItem.skillHbox");
         _avatar = new MonsterShowAvatar();
         addChild(_back);
         addChild(_avatar);
         addChild(_skillHbox);
         addChild(_nameText);
         _avatar.x = 90;
         _avatar.y = 155;
         _avatar.mouseChildren = _avatar.mouseEnabled = false;
         this.mouseEnabled = false;
      }
      
      public function get data() : MonsterTempInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterTempInfo) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:SkillTempInfo = null;
         var _loc5_:BaseIconView = null;
         _data = param1;
         if(data)
         {
            _nameText.text = data.Name;
            if(preType != data.Type + "_" + data.Star)
            {
               _avatar.data = data;
               _avatar.setBodyScale(data.Scale / 100);
               _avatar.x = _avatar.getPosLeg().x + 75;
               _avatar.y = _avatar.getPosLeg().y + 135 + data.Offset;
               _skillHbox.removeAllChild();
               _loc2_ = model.getShowSkillByMonster(data);
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc4_ = _loc2_[_loc3_];
                  _loc5_ = ComponentFactory.Instance.creatCustomObject("MonsterHandBookItem.skillItem");
                  _loc5_.icon = IconFactory.getTecIconByIcon(_loc4_.Icons);
                  _loc5_.tipData = _loc4_;
                  _skillHbox.addChild(_loc5_);
                  _loc3_++;
               }
            }
            preType = data.Type + "_" + data.Star;
         }
         else
         {
            _skillHbox.removeAllChild();
            _avatar.data = null;
            _nameText.text = "";
            preType = "";
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_skillHbox);
         _skillHbox = null;
         super.dispose();
      }
   }
}

