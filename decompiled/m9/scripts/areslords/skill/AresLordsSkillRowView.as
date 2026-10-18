package areslords.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   
   public class AresLordsSkillRowView extends Component implements IListCell
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _skillBox:HBox;
      
      private var _splitLine:Image;
      
      private var _skillList:Vector.<AresLordsSkillItemView>;
      
      public function AresLordsSkillRowView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslords.SkillFrameSkillBg");
         _skillBox = ComponentFactory.Instance.creatComponentByStylename("areslords.SkillFrameBox");
         _splitLine = ComponentFactory.Instance.creatComponentByStylename("areslords.SkillFrameSplit");
         addChild(_bg);
         addChild(_skillBox);
         addChild(_splitLine);
         _skillList = new Vector.<AresLordsSkillItemView>();
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _skillList.push(ComponentFactory.Instance.creatComponentByStylename("areslords.SkillFrameSkillItemView"));
            _skillBox.addChild(_skillList[_loc1_]);
            _skillList[_loc1_].data = null;
            _loc1_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_skillBox);
         _skillBox = null;
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         if(_skillList)
         {
            while(_skillList.length)
            {
               ObjectUtils.disposeObject(_skillList.pop());
            }
            _skillList = null;
         }
         ObjectUtils.disposeObject(_skillBox);
         _skillBox = null;
         super.dispose();
      }
      
      public function getCellValue() : *
      {
         return null;
      }
      
      public function setCellValue(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1)
         {
            _loc3_ = 0;
            _loc2_ = int(_skillList.length);
            while(_loc3_ < _loc2_)
            {
               _skillList[_loc3_].data = param1[_loc3_];
               _loc3_++;
            }
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
   }
}

