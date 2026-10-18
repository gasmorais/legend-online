package chess
{
   import chess.item.SelfChessOneBuffDes;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.chess.SelfChessManager;
   import yishi.datas.templates.SelfChessBuffTempInfo;
   import yishi.view.tips.BaseTip;
   
   public class SelfChessBuffTip extends BaseTip
   {
      
      private var _vbox:VBox;
      
      private var _list:Array = [];
      
      public function SelfChessBuffTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _vbox = ComponentFactory.Instance.creatCustomObject("ui.selfchess.buffOutVbox");
         addChild(_vbox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:SelfChessBuffTempInfo = null;
         var _loc4_:int = 0;
         var _loc6_:Boolean = false;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = tipData as Array;
         if(_loc1_)
         {
            _vbox.removeAllChild();
            _vbox.beginChanges();
            _loc2_ = _loc1_[0];
            _loc4_ = int(_loc1_.length);
            _loc3_ = int(SelfChessManager.Ins.model.getJobNum(_loc2_.Job));
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc2_ = _loc1_[_loc5_];
               if(_loc2_)
               {
                  if(_loc2_.Amount <= _loc3_ && !_loc6_)
                  {
                     _loc6_ = true;
                     creatOneBuff(_loc2_,_loc5_,true);
                  }
                  else
                  {
                     creatOneBuff(_loc2_,_loc5_,false);
                  }
               }
               _loc5_++;
            }
            _vbox.commitChanges();
            _bg.height = _vbox.y + _vbox.displayHeight + 10;
         }
      }
      
      private function creatOneBuff(param1:SelfChessBuffTempInfo, param2:int, param3:Boolean) : void
      {
         var _loc4_:SelfChessOneBuffDes = _list[param2];
         if(_loc4_ == null)
         {
            _loc4_ = new SelfChessOneBuffDes();
            _list[param2] = _loc4_;
         }
         _loc4_.isActive = param3;
         _loc4_.refreshView(param1);
         _vbox.addChild(_loc4_);
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:SelfChessOneBuffDes in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _list = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         super.dispose();
      }
   }
}

