package child
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   
   public class ChildListItemCell extends Component
   {
      
      private var cellBack:Bitmap;
      
      private var selectBg:Bitmap;
      
      private var nameText:FilterFrameText;
      
      private var levelText:FilterFrameText;
      
      private var enterWarIcon:ScaleFrameImage;
      
      private var _isSelected:Boolean;
      
      private var _data:ChildData;
      
      public function ChildListItemCell()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         cellBack = ComponentFactory.Instance.creatBitmap("asset.ChildListItemCell.cellBack");
         selectBg = ComponentFactory.Instance.creatBitmap("asset.ChildListItemCell.selectBg");
         nameText = ComponentFactory.Instance.creatComponentByStylename("ChildListItemCell.nameText");
         levelText = ComponentFactory.Instance.creatComponentByStylename("ChildListItemCell.levelText");
         enterWarIcon = ComponentFactory.Instance.creatComponentByStylename("ChildListItemCell.enterWarIcon");
         addChild(cellBack);
         addChild(selectBg);
         addChild(nameText);
         addChild(levelText);
         addChild(enterWarIcon);
         enterWarIcon.setFrame(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__childIteCellSelectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__childIteCellSelectHandler);
      }
      
      private function __childIteCellSelectHandler(param1:MouseEvent) : void
      {
         model.selectedChild = data;
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         _data = param1;
         if(_data)
         {
            nameText.text = _data.name;
            if(nameText.numLines > 1)
            {
               nameText.y = 0;
            }
            else
            {
               nameText.y = 8;
            }
            levelText.text = LanguageMgr.GetTranslation("public.level2",_data.growthGrade);
            if(_data.fightUserId == playerInfo.userId)
            {
               enterWarIcon.setFrame(2);
            }
            else if(_data.fightSlaveUserId == playerInfo.userId)
            {
               enterWarIcon.setFrame(3);
            }
            else
            {
               enterWarIcon.setFrame(1);
            }
         }
      }
      
      public function get selected() : Boolean
      {
         return _isSelected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _isSelected = param1;
         selectBg.visible = _isSelected;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(cellBack);
         cellBack = null;
         ObjectUtils.disposeObject(selectBg);
         selectBg = null;
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         ObjectUtils.disposeObject(levelText);
         levelText = null;
         ObjectUtils.disposeObject(enterWarIcon);
         enterWarIcon = null;
         super.dispose();
      }
   }
}

