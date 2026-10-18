package mvc.controler
{
   import mvc.FrameController;
   import mvc.module.box.GradeBoxModel;
   import yishi.datas.goods.GoodsInfo;
   
   public class GradeBoxControler extends FrameController
   {
      
      private var _model:GradeBoxModel = new GradeBoxModel();
      
      public function GradeBoxControler()
      {
         super();
      }
      
      public function get data() : GoodsInfo
      {
         return _data.frameData as GoodsInfo;
      }
      
      override public function get frameClassName() : String
      {
         return "gradebox.GradeBoxFrame";
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
         _data = null;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function get model() : GradeBoxModel
      {
         return _model;
      }
   }
}

