package monster.cell
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import monster.mediator.MonsterAccessoriesBagCellClickMediator;
   import monster.mediator.MonsterAccessoriesBagCellDropMediator;
   import monster.mediator.MonsterAccessoriesBagCellLightMediator;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   import yishi.manager.MonsterManager;
   import yishi.view.community.BaseItemView;
   
   public class MonsterAccessoriesBagCell extends BaseItemView
   {
      
      public static const NAME:String = "monster.cell.MonsterAccessoriesBagCell";
      
      private var _countText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _equipIcon:Image;
      
      private var _isNewImage:Image;
      
      protected var _mediatorKey:String;
      
      public function MonsterAccessoriesBagCell()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _countText = ComponentFactory.Instance.creatComponentByStylename("core.BaseItemText");
         _equipIcon = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesBagCell.equipIcon");
         _isNewImage = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesBagCell.isNewImage");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("MonsterAccessoriesBagCell.gradeText");
         _equipIcon.visible = false;
         _isNewImage.visible = false;
         _equipIcon.mouseChildren = _equipIcon.mouseEnabled = false;
         _isNewImage.mouseChildren = _isNewImage.mouseEnabled = false;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_equipIcon)
         {
            addChild(_equipIcon);
         }
         if(_isNewImage)
         {
            addChild(_isNewImage);
         }
         if(_countText)
         {
            addChild(_countText);
         }
         if(_gradeText)
         {
            addChild(_gradeText);
         }
      }
      
      public function addEvent() : void
      {
         var _loc1_:Array = [MonsterAccessoriesBagCellClickMediator,MonsterAccessoriesBagCellDropMediator,MonsterAccessoriesBagCellLightMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"monster.cell.MonsterAccessoriesBagCell");
      }
      
      public function removeEvent() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(data)
         {
            _equipIcon.visible = data.objectId != 0;
            _isNewImage.visible = data.isNew;
            if(data.templateInfo.SonType == 232)
            {
               _gradeText.text = data.strengthenGrade > 0 ? LanguageMgr.GetTranslation("public.level2",data.strengthenGrade) : "";
            }
            else
            {
               _countText.text = data.count + "";
            }
         }
         else
         {
            _countText.text = "";
            _gradeText.text = "";
            _equipIcon.visible = false;
            _isNewImage.visible = false;
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_equipIcon);
         _equipIcon = null;
         ObjectUtils.disposeObject(_isNewImage);
         _isNewImage = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         super.dispose();
      }
   }
}

